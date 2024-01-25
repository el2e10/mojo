# ===----------------------------------------------------------------------=== #
#
# This file is Modular Inc proprietary.
#
# ===----------------------------------------------------------------------=== #
"""Implements methods for querying the host target info.

You can import these APIs from the `sys` package. For example:

```mojo
from sys.info import is_x86
```
"""

from .ffi import _external_call_const


@always_inline("nodebug")
fn _current_target() -> __mlir_type.`!kgen.target`:
    return __mlir_attr.`#kgen.param.expr<current_target> : !kgen.target`


@always_inline("nodebug")
fn _current_cpu() -> __mlir_type.`!kgen.string`:
    return __mlir_attr[
        `#kgen.param.expr<target_get_field,`,
        _current_target(),
        `, "arch" : !kgen.string`,
        `> : !kgen.string`,
    ]


@always_inline("nodebug")
fn is_x86() -> Bool:
    """Returns True if the host system architecture is X86 and False otherwise.

    Returns:
        True if the host system architecture is X86 and False otherwise.
    """
    return has_sse4()


@always_inline("nodebug")
fn has_sse4() -> Bool:
    """Returns True if the host system has sse4, otherwise returns False.

    Returns:
        True if the host system has sse4, otherwise returns False.
    """
    return __mlir_attr[
        `#kgen.param.expr<target_has_feature,`,
        _current_target(),
        `, "sse4.2" : !kgen.string`,
        `> : i1`,
    ]


@always_inline("nodebug")
fn has_avx() -> Bool:
    """Returns True if the host system has AVX, otherwise returns False.

    Returns:
        True if the host system has AVX, otherwise returns False.
    """
    return __mlir_attr[
        `#kgen.param.expr<target_has_feature,`,
        _current_target(),
        `, "avx" : !kgen.string`,
        `> : i1`,
    ]


@always_inline("nodebug")
fn has_avx2() -> Bool:
    """Returns True if the host system has AVX2, otherwise returns False.

    Returns:
        True if the host system has AVX2, otherwise returns False.
    """
    return __mlir_attr[
        `#kgen.param.expr<target_has_feature,`,
        _current_target(),
        `, "avx2" : !kgen.string`,
        `> : i1`,
    ]


@always_inline("nodebug")
fn has_avx512f() -> Bool:
    """Returns True if the host system has AVX512, otherwise returns False.

    Returns:
        True if the host system has AVX512, otherwise returns False.
    """
    return __mlir_attr[
        `#kgen.param.expr<target_has_feature,`,
        _current_target(),
        `, "avx512f" : !kgen.string`,
        `> : i1`,
    ]


@always_inline("nodebug")
fn has_vnni() -> Bool:
    """Returns True if the host system has avx512_vnni, otherwise returns False.

    Returns:
        True if the host system has avx512_vnni, otherwise returns False.
    """
    return (
        __mlir_attr[
            `#kgen.param.expr<target_has_feature,`,
            _current_target(),
            `, "avx512vnni" : !kgen.string`,
            `> : i1`,
        ]
        or __mlir_attr[
            `#kgen.param.expr<target_has_feature,`,
            _current_target(),
            `, "avxvnni" : !kgen.string`,
            `> : i1`,
        ]
    )


@always_inline("nodebug")
fn has_neon() -> Bool:
    """Returns True if the host system has Neon support, otherwise returns
    False.

    Returns:
        True if the host system support the Neon instruction set.
    """
    return (
        is_apple_m1()
        | __mlir_attr[
            `#kgen.param.expr<target_has_feature,`,
            _current_target(),
            `, "neon" : !kgen.string`,
            `> : i1`,
        ]
    )


@always_inline("nodebug")
fn has_neon_int8_dotprod() -> Bool:
    """Returns True if the host system has the Neon int8 dot product extension,
    otherwise returns False.

    Returns:
        True if the host system support the Neon int8 dot product extension and
        False otherwise.
    """
    return (
        has_neon()
        and __mlir_attr[
            `#kgen.param.expr<target_has_feature,`,
            _current_target(),
            `, "dotprod" : !kgen.string`,
            `> : i1`,
        ]
    )


@always_inline("nodebug")
fn has_neon_int8_matmul() -> Bool:
    """Returns True if the host system has the Neon int8 matrix multiplication
    extension (I8MM), otherwise returns False.

    Returns:
        True if the host system support the Neon int8 matrix multiplication
        extension (I8MM) and False otherwise.
    """
    return (
        has_neon()
        and __mlir_attr[
            `#kgen.param.expr<target_has_feature,`,
            _current_target(),
            `, "i8mm" : !kgen.string`,
            `> : i1`,
        ]
    )


@always_inline("nodebug")
fn is_apple_m1() -> Bool:
    """Returns True if the host system is an Apple M1 with AMX support,
    otherwise returns False.

    Returns:
        True if the host system is an Apple M1 with AMX support and False
        otherwise.
    """
    return __mlir_attr[
        `#kgen.param.expr<eq,`,
        _current_cpu(),
        `, "apple-m1" : !kgen.string`,
        `> : i1`,
    ]


@always_inline("nodebug")
fn is_neoverse_n1() -> Bool:
    """Returns True if the host system is a Neoverse N1 system, otherwise
    returns False.

    Returns:
        True if the host system is a Neoverse N1 system and False otherwise.
    """
    return __mlir_attr[
        `#kgen.param.expr<eq,`,
        _current_cpu(),
        `, "neoverse-n1" : !kgen.string`,
        `> : i1`,
    ]


@always_inline("nodebug")
fn has_intel_amx() -> Bool:
    """Returns True if the host system has Intel AMX support, otherwise returns
    False.

    Returns:
        True if the host system has Intel AMX and False otherwise.
    """
    return __mlir_attr[
        `#kgen.param.expr<target_has_feature,`,
        _current_target(),
        `, "amx-tile" : !kgen.string`,
        `> : i1`,
    ]


@always_inline("nodebug")
fn _os_attr() -> __mlir_type.`!kgen.string`:
    return __mlir_attr[
        `#kgen.param.expr<target_get_field,`,
        _current_target(),
        `, "os" : !kgen.string`,
        `> : !kgen.string`,
    ]


@always_inline("nodebug")
fn os_is_macos() -> Bool:
    """Returns True if the host operating system is macOS.

    Returns:
        True if the host operating system is macOS and False otherwise.
    """
    return (
        __mlir_attr[
            `#kgen.param.expr<eq,`,
            _os_attr(),
            `,`,
            `"darwin" : !kgen.string`,
            `> : i1`,
        ]
        or __mlir_attr[
            `#kgen.param.expr<eq,`,
            _os_attr(),
            `,`,
            `"macosx" : !kgen.string`,
            `> : i1`,
        ]
    )


@always_inline("nodebug")
fn os_is_linux() -> Bool:
    """Returns True if the host operating system is Linux.

    Returns:
        True if the host operating system is Linux and False otherwise.
    """
    return __mlir_attr[
        `#kgen.param.expr<eq,`,
        _os_attr(),
        `,`,
        `"linux" : !kgen.string`,
        `> : i1`,
    ]


@always_inline("nodebug")
fn os_is_windows() -> Bool:
    """Returns True if the host operating system is Windows.

    Returns:
        True if the host operating system is Windows and False otherwise.
    """
    return __mlir_attr[
        `#kgen.param.expr<eq,`,
        _os_attr(),
        `,`,
        `"windows" : !kgen.string`,
        `> : i1`,
    ]


@always_inline("nodebug")
fn _triple_attr() -> __mlir_type.`!kgen.string`:
    return __mlir_attr[
        `#kgen.param.expr<target_get_field,`,
        _current_target(),
        `, "triple" : !kgen.string`,
        `> : !kgen.string`,
    ]


@always_inline("nodebug")
fn is_triple[triple: StringLiteral]() -> Bool:
    """Returns True if the target triple of the compiler matches the input and
    False otherwise.

    Parameters:
      triple: The triple value to be checked against.

    Returns:
        True if the triple matches and False otherwise.
    """
    return __mlir_attr[
        `#kgen.param.expr<eq,`,
        _triple_attr(),
        `, `,
        triple.value,
        `> : i1`,
    ]


@always_inline("nodebug")
fn triple_is_nvidia_cuda() -> Bool:
    """Returns True if the target triple of the compiler is `nvptx64-nvidia-cuda`
    False otherwise.

    Returns:
        True if the triple target is cuda and False otherwise.
    """
    return is_triple["nvptx64-nvidia-cuda"]()


@always_inline("nodebug")
fn is_little_endian[
    target: __mlir_type.`!kgen.target` = _current_target()
]() -> Bool:
    """Returns True if the host endianness is little and False otherwise.

    Parameters:
        target: The target architecture.

    Returns:
        True if the host target is little endian and False otherwise.
    """
    return __mlir_attr[
        `#kgen.param.expr<eq,`,
        __mlir_attr[
            `#kgen.param.expr<target_get_field,`,
            _current_target(),
            `, "endianness" : !kgen.string`,
            `> : !kgen.string`,
        ],
        `,`,
        `"little" : !kgen.string`,
        `> : i1`,
    ]


@always_inline("nodebug")
fn is_big_endian[
    target: __mlir_type.`!kgen.target` = _current_target()
]() -> Bool:
    """Returns True if the host endianness is big and False otherwise.

    Parameters:
        target: The target architecture.

    Returns:
        True if the host target is big endian and False otherwise.
    """
    return __mlir_attr[
        `#kgen.param.expr<eq,`,
        __mlir_attr[
            `#kgen.param.expr<target_get_field,`,
            target,
            `, "endianness" : !kgen.string`,
            `> : !kgen.string`,
        ],
        `,`,
        `"big" : !kgen.string`,
        `> : i1`,
    ]


@always_inline("nodebug")
fn simdbitwidth[
    target: __mlir_type.`!kgen.target` = _current_target()
]() -> Int:
    """Returns the vector size (in bits) of the host system.

    Parameters:
        target: The target architecture.

    Returns:
        The vector size (in bits) of the host system.
    """
    return __mlir_attr[
        `#kgen.param.expr<target_get_field,`,
        target,
        `, "simd_bit_width" : !kgen.string`,
        `> : index`,
    ]


@always_inline("nodebug")
fn simdbytewidth[
    target: __mlir_type.`!kgen.target` = _current_target()
]() -> Int:
    """Returns the vector size (in bytes) of the host system.

    Parameters:
        target: The target architecture.

    Returns:
        The vector size (in bytes) of the host system.
    """
    alias CHAR_BIT = 8
    return simdbitwidth[target]() // CHAR_BIT


@always_inline("nodebug")
fn sizeof[
    type: AnyRegType, target: __mlir_type.`!kgen.target` = _current_target()
]() -> Int:
    """Returns the size of (in bytes) of the type.

    Parameters:
        type: The type in question.
        target: The target architecture.

    Returns:
        The size of the type in bytes.
    """
    return __mlir_attr[
        `#kgen.param.expr<get_sizeof, #kgen.parameterizedtype.constant<`,
        type,
        `> : !kgen.type,`,
        target,
        `> : index`,
    ]


@always_inline("nodebug")
fn sizeof[
    type: DType, target: __mlir_type.`!kgen.target` = _current_target()
]() -> Int:
    """Returns the size of (in bytes) of the dtype.

    Parameters:
        type: The DType in question.
        target: The target architecture.

    Returns:
        The size of the dtype in bytes.
    """
    return __mlir_attr[
        `#kgen.param.expr<get_sizeof, #kgen.parameterizedtype.constant<`,
        `!pop.scalar<`,
        type.value,
        `>`,
        `> : !kgen.type,`,
        target,
        `> : index`,
    ]


@always_inline("nodebug")
fn alignof[
    type: AnyRegType, target: __mlir_type.`!kgen.target` = _current_target()
]() -> Int:
    """Returns the align of (in bytes) of the type.

    Parameters:
        type: The type in question.
        target: The target architecture.

    Returns:
        The alignment of the type in bytes.
    """
    return __mlir_attr[
        `#kgen.param.expr<get_alignof, #kgen.parameterizedtype.constant<`,
        type,
        `> : !kgen.type,`,
        target,
        `> : index`,
    ]


@always_inline("nodebug")
fn alignof[
    type: DType, target: __mlir_type.`!kgen.target` = _current_target()
]() -> Int:
    """Returns the align of (in bytes) of the dtype.

    Parameters:
        type: The DType in question.
        target: The target architecture.

    Returns:
        The alignment of the dtype in bytes.
    """
    return __mlir_attr[
        `#kgen.param.expr<get_alignof, #kgen.parameterizedtype.constant<`,
        `!pop.scalar<`,
        type.value,
        `>`,
        `> : !kgen.type,`,
        target,
        `> : index`,
    ]


@always_inline("nodebug")
fn bitwidthof[
    type: AnyRegType, target: __mlir_type.`!kgen.target` = _current_target()
]() -> Int:
    """Returns the size of (in bits) of the type.

    Parameters:
        type: The type in question.
        target: The target architecture.

    Returns:
        The size of the type in bits.
    """
    alias CHAR_BIT = 8
    return CHAR_BIT * sizeof[type, target=target]()


@always_inline("nodebug")
fn bitwidthof[
    type: DType, target: __mlir_type.`!kgen.target` = _current_target()
]() -> Int:
    """Returns the size of (in bits) of the dtype.

    Parameters:
        type: The type in question.
        target: The target architecture.

    Returns:
        The size of the dtype in bits.
    """
    return bitwidthof[
        __mlir_type[`!pop.scalar<`, type.value, `>`], target=target
    ]()


@always_inline("nodebug")
fn simdwidthof[
    type: AnyRegType, target: __mlir_type.`!kgen.target` = _current_target()
]() -> Int:
    """Returns the vector size of the type on the host system.

    Parameters:
        type: The type in question.
        target: The target architecture.

    Returns:
        The vector size of the type on the host system.
    """
    return simdbitwidth[target]() // bitwidthof[type, target]()


@always_inline("nodebug")
fn simdwidthof[
    type: DType, target: __mlir_type.`!kgen.target` = _current_target()
]() -> Int:
    """Returns the vector size of the type on the host system.

    Parameters:
        type: The DType in question.
        target: The target architecture.

    Returns:
        The vector size of the dtype on the host system.
    """
    return simdwidthof[__mlir_type[`!pop.scalar<`, type.value, `>`], target]()


@always_inline("nodebug")
fn num_physical_cores() -> Int:
    """Returns the number of physical cores across all CPU sockets.


    Returns:
        Int: The number of physical cores on the system.
    """
    return _external_call_const["KGEN_CompilerRT_NumPhysicalCores", Int]()


@always_inline
fn num_logical_cores() -> Int:
    """Returns the number of hardware threads, including hyperthreads across all
    CPU sockets.

    Returns:
        Int: The number of threads on the system.
    """
    return _external_call_const["KGEN_CompilerRT_NumLogicalCores", Int]()


@always_inline
fn num_performance_cores() -> Int:
    """Returns the number of physical performance cores across all CPU sockets.
    If not known, returns the total number of physical cores.

    Returns:
        Int: The number of physical performance cores on the system.
    """
    return _external_call_const["KGEN_CompilerRT_NumPerformanceCores", Int]()
