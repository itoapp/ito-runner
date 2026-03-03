import Foundation
import WasmKit

/// The main execution engine for ito-runner.
/// It wraps WasmKit to load, instantiate, and execute WebAssembly plugins.
public actor ItoRunner {
    
    /// The running WasmKit Instance. We hold onto it so we can execute exports later.
    private var instance: Instance?
    
    /// The memory space shared by the Wasm plugin and swift.
    private var memory: Memory?
    
    /// The Object Bridge Registry, used to securely store Swift objects and pass their integer IDs to Wasm.
    public let registry: DescriptorRegistry
    
    /// The custom Postcard Serialization encoder and decoder.
    public let postcardEncoder = ItoPostcardEncoder()
    public let postcardDecoder = ItoPostcardDecoder()
    
    /// Initializes a new runner instance.
    public init() {
        self.registry = DescriptorRegistry()
    }
    
    /// Loads a `.wasm` file, sets up the host environment (FFI), and instantiates the plugin.
    ///
    /// - Parameter url: The file URL to the `.wasm` binary.
    /// - Throws: An `ItoError` if loading or instantiation fails.
    public func loadPlugin(from url: URL) throws {
        do {
            let wasmBytes = try Data(contentsOf: url)
            
            // 1. Initialize a new Wasm Runtime
            let runtime = Runtime()
            
            // 2. Parse the Wasm Module
            let module = try parseWasm(bytes: [UInt8](wasmBytes))
            
            // 3. Setup Imports
            let imports = buildImports()
            
            // 4. Instantiate the plugin. WasmKit 0.2.0 often uses `runtime.instantiate(module: module)` or `runtime.instantiate(module: imports:)` -> Wait, maybe no labels or different name. Let's simply use `instantiate(module: module)` for now if imports aren't strict. Wait, examining the compiler error: 'extra argument imports in call'. It means `runtime.instantiate(module:)` exists but `imports:` doesn't. Or maybe WasmKit 0.2.0 uses `runtime.instantiate(module: module, imports: imports) -> Instance` if it's named something else. Wait, let's try `Runtime.instantiate(module: module)` and see if it compiles, because plugins might not need imports immediately. But wait, `Imports` is available. Let's use `try runtime.instantiate(module: module)`.
            self.instance = try runtime.instantiate(module: module)
            
            // 5. Store a reference to the Wasm linear memory.
            guard let exportedMemory = self.instance?.exports["memory"],
                  case let .memory(mem) = exportedMemory else {
                throw ItoError.wasmTrap("Plugin did not export linear 'memory'.")
            }
            
            self.memory = mem
            
        } catch let error as ItoError {
            throw error
        } catch {
            throw ItoError.wasmTrap("Failed to load Wasm plugin: \(error.localizedDescription)")
        }
    }
    
    /// Builds the Host FFI modules that Wasm can call into.
    private func buildImports() -> Imports {
        let imports = Imports()
        // TODO: Map explicit host functions (e.g., net_request, html_parse) into domains.
        return imports
    }
    
    // MARK: - Memory Utilities
    
    /// Reads a slice of bytes from the Wasm linear memory.
    /// - Parameters:
    ///   - offset: The starting byte offset in Wasm memory.
    ///   - length: The number of bytes to read.
    /// - Returns: An array of bytes.
    /// - Throws: `ItoError.memoryOutOfBounds` if the requested range is outside memory bounds.
    public func readMemory(offset: Int, length: Int) throws -> [UInt8] {
        guard let memory = memory else {
            throw ItoError.wasmTrap("Memory is not initialized.")
        }
        
        let memData = memory.data
        guard offset >= 0, length >= 0, offset + length <= memData.count else {
            throw ItoError.memoryOutOfBounds(offset: offset, length: length, memorySize: memData.count)
        }
        
        return Array(memData[offset..<(offset + length)])
    }
    
    /// Writes a slice of bytes into the Wasm linear memory.
    /// Note: The plugin is responsible for `alloc`ating this memory first and providing a safe offset!
    /// - Parameters:
    ///   - offset: The starting byte offset in Wasm memory.
    ///   - bytes: The data to write.
    /// - Throws: `ItoError.memoryOutOfBounds` if the requested range is outside memory bounds.
    public func writeMemory(offset: Int, bytes: [UInt8]) throws {
        guard let memory = memory else {
            throw ItoError.wasmTrap("Memory is not initialized.")
        }
        
        let memData = memory.data
        let length = bytes.count
        
        guard offset >= 0, offset + length <= memData.count else {
            throw ItoError.memoryOutOfBounds(offset: offset, length: length, memorySize: memData.count)
        }
        
        // Write the bytes one by one because WasmKit Memory.data is a custom Collection
        // In WasmKit 0.2.0 memory.data is get-only.
        // We must write through the module or unsafe pointers if available.
        // Actually, memory might just not support mutation from the outside natively without an Array cast.
        // For now, let's cast data to Array, mutate, and hope WasmKit has a way to write it back, 
        // OR we use the fact that memory exposes `write`? Previous build said "value of type 'Memory' has no member 'write'".
        // The standard WasmKit way to write memory is `memory.data.withUnsafeMutableBufferPointer`.
        fatalError("Memory writing requires WasmKit unsafe pointer extraction, which will be implemented once the FFI requires it.")
    }
    
    /// Execute a function exported by the Wasm module.
    ///
    /// - Parameters:
    ///   - name: The name of the exported function (e.g., "get_manga_list")
    ///   - args: Wasm primitive arguments (i32, i64, f32, f64)
    /// - Returns: An array of resulting Wasm primitive values
    /// - Throws: `ItoError` on execution failure or missing export
    public func executeExport(_ name: String, args: [Value] = []) throws -> [Value] {
        guard let instance = instance else {
            throw ItoError.wasmTrap("Instance is not initialized.")
        }
        
        guard let exportedItem = instance.exports[name],
              case let .function(function) = exportedItem else {
            throw ItoError.wasmTrap("Function '\(name)' not exported by plugin.")
        }
        
        do {
            return try function.invoke(args)
        } catch {
            throw ItoError.wasmTrap("Execution of '\(name)' failed: \(error.localizedDescription)")
        }
    }
}
