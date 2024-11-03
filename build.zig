const std = @import("std");

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});

    const slikenet = b.addModule("root", .{
        .root_source_file = b.path("bindings/zig/slikenet.zig"),
    });
    slikenet.addIncludePath(b.path("bindings/zig/"));

    const slikenetc = b.addStaticLibrary(.{
        .name = "slikenetc",
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(slikenetc);

    slikenetc.addIncludePath(b.path("Source/include/"));
    slikenetc.linkLibC();
    if (target.result.abi != .msvc)
        slikenetc.linkLibCpp();

    slikenetc.addCSourceFiles(.{
        .files = &.{
            "bindings/zig/slikenet.cpp",

            "Source/src/_FindFirst.cpp",
            "Source/src/Base64Encoder.cpp",
            "Source/src/BitStream.cpp",
            "Source/src/CCRakNetSlidingWindow.cpp",
            "Source/src/CCRakNetUDT.cpp",
            "Source/src/CheckSum.cpp",
            "Source/src/CloudClient.cpp",
            "Source/src/CloudCommon.cpp",
            "Source/src/CloudServer.cpp",
            "Source/src/CommandParserInterface.cpp",
            "Source/src/ConnectionGraph2.cpp",
            "Source/src/ConsoleServer.cpp",
            "Source/src/DataCompressor.cpp",
            "Source/src/DirectoryDeltaTransfer.cpp",
            "Source/src/DR_SHA1.cpp",
            "Source/src/DS_BytePool.cpp",
            "Source/src/DS_ByteQueue.cpp",
            "Source/src/DS_HuffmanEncodingTree.cpp",
            "Source/src/DS_Table.cpp",
            "Source/src/DynDNS.cpp",
            "Source/src/EmailSender.cpp",
            "Source/src/EpochTimeToString.cpp",
            "Source/src/FileList.cpp",
            "Source/src/FileListTransfer.cpp",
            "Source/src/FileOperations.cpp",
            "Source/src/FormatString.cpp",
            "Source/src/FullyConnectedMesh2.cpp",
            "Source/src/Getche.cpp",
            "Source/src/Gets.cpp",
            "Source/src/GetTime.cpp",
            "Source/src/gettimeofday.cpp",
            "Source/src/GridSectorizer.cpp",
            "Source/src/HTTPConnection.cpp",
            "Source/src/HTTPConnection2.cpp",
            "Source/src/IncrementalReadInterface.cpp",
            "Source/src/Itoa.cpp",
            "Source/src/linux_adapter.cpp",
            "Source/src/LinuxStrings.cpp",
            "Source/src/LocklessTypes.cpp",
            "Source/src/LogCommandParser.cpp",
            "Source/src/MessageFilter.cpp",
            "Source/src/NatPunchthroughClient.cpp",
            "Source/src/NatPunchthroughServer.cpp",
            "Source/src/NatTypeDetectionClient.cpp",
            "Source/src/NatTypeDetectionCommon.cpp",
            "Source/src/NatTypeDetectionServer.cpp",
            "Source/src/NetworkIDManager.cpp",
            "Source/src/NetworkIDObject.cpp",
            "Source/src/osx_adapter.cpp",
            "Source/src/PacketConsoleLogger.cpp",
            "Source/src/PacketFileLogger.cpp",
            "Source/src/PacketizedTCP.cpp",
            "Source/src/PacketLogger.cpp",
            "Source/src/PacketOutputWindowLogger.cpp",
            "Source/src/PluginInterface2.cpp",
            "Source/src/PS4Includes.cpp",
            "Source/src/Rackspace.cpp",
            "Source/src/RakMemoryOverride.cpp",
            "Source/src/RakNetCommandParser.cpp",
            "Source/src/RakNetSocket.cpp",
            "Source/src/RakNetSocket2.cpp",
            "Source/src/RakNetSocket2_360_720.cpp",
            "Source/src/RakNetSocket2_Berkley.cpp",
            "Source/src/RakNetSocket2_Berkley_NativeClient.cpp",
            "Source/src/RakNetSocket2_NativeClient.cpp",
            "Source/src/RakNetSocket2_PS3_PS4.cpp",
            "Source/src/RakNetSocket2_PS4.cpp",
            "Source/src/RakNetSocket2_Vita.cpp",
            "Source/src/RakNetSocket2_Windows_Linux.cpp",
            "Source/src/RakNetSocket2_Windows_Linux_360.cpp",
            "Source/src/RakNetSocket2_WindowsStore8.cpp",
            "Source/src/RakNetStatistics.cpp",
            "Source/src/RakNetTransport2.cpp",
            "Source/src/RakNetTypes.cpp",
            "Source/src/RakPeer.cpp",
            "Source/src/RakSleep.cpp",
            "Source/src/RakString.cpp",
            "Source/src/RakThread.cpp",
            "Source/src/RakWString.cpp",
            "Source/src/Rand.cpp",
            "Source/src/RandSync.cpp",
            "Source/src/ReadyEvent.cpp",
            "Source/src/RelayPlugin.cpp",
            "Source/src/ReliabilityLayer.cpp",
            "Source/src/ReplicaManager3.cpp",
            "Source/src/Router2.cpp",
            "Source/src/RPC4Plugin.cpp",
            "Source/src/SecureHandshake.cpp",
            "Source/src/SendToThread.cpp",
            "Source/src/SignaledEvent.cpp",
            "Source/src/SimpleMutex.cpp",
            "Source/src/SocketLayer.cpp",
            "Source/src/StatisticsHistory.cpp",
            "Source/src/StringCompressor.cpp",
            "Source/src/StringTable.cpp",
            "Source/src/SuperFastHash.cpp",
            "Source/src/TableSerializer.cpp",
            "Source/src/TCPInterface.cpp",
            "Source/src/TeamBalancer.cpp",
            "Source/src/TeamManager.cpp",
            "Source/src/TelnetTransport.cpp",
            "Source/src/ThreadsafePacketLogger.cpp",
            "Source/src/TwoWayAuthentication.cpp",
            "Source/src/UDPForwarder.cpp",
            "Source/src/UDPProxyClient.cpp",
            "Source/src/UDPProxyCoordinator.cpp",
            "Source/src/UDPProxyServer.cpp",
            "Source/src/VariableDeltaSerializer.cpp",
            "Source/src/VariableListDeltaTracker.cpp",
            "Source/src/VariadicSQLParser.cpp",
            "Source/src/VitaIncludes.cpp",
            "Source/src/WSAStartupSingleton.cpp",

            "Source/src/crypto/cryptomanager.cpp",
            "Source/src/crypto/factory.cpp",
            "Source/src/crypto/fileencrypter.cpp",
            "Source/src/crypto/securestring.cpp",
        },
        .flags = &.{
            "-std=c++17",
        },
    });
    const test_step = b.step("test", "Run slikenet tests");

    const tests = b.addTest(.{
        .name = "slikenet-tests",
        .root_source_file = b.path("src/slikenet.zig"),
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(tests);
    tests.addIncludePath(b.path("Source/include/"));
    tests.linkLibrary(slikenetc);
    test_step.dependOn(&b.addRunArtifact(tests).step);
}
