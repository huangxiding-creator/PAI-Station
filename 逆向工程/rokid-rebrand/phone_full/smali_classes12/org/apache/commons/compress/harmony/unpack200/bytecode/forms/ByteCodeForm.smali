.class public abstract Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;
.super Ljava/lang/Object;
.source "ByteCodeForm.java"


# static fields
.field protected static final WIDENED:Z = true

.field protected static final byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

.field protected static final byteCodesByName:Ljava/util/Map;


# instance fields
.field private firstOperandIndex:I

.field private final name:Ljava/lang/String;

.field private final opcode:I

.field private operandLength:I

.field private final rewrite:[I


# direct methods
.method static constructor <clinit>()V
    .locals 16

    .line 30
    const/16 v0, 0x100

    new-array v0, v0, [Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    sput-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    .line 31
    new-instance v0, Ljava/util/HashMap;

    const/16 v1, 0x100

    invoke-direct {v0, v1}, Ljava/util/HashMap;-><init>(I)V

    sput-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodesByName:Ljava/util/Map;

    .line 33
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const-string v2, "nop"

    const/4 v3, 0x0

    invoke-direct {v1, v3, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v3

    .line 34
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const-string v2, "aconst_null"

    const/4 v4, 0x1

    invoke-direct {v1, v4, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v4

    .line 35
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/4 v2, 0x2

    const-string v5, "iconst_m1"

    invoke-direct {v1, v2, v5}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 36
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/4 v2, 0x3

    const-string v5, "iconst_0"

    invoke-direct {v1, v2, v5}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 37
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/4 v2, 0x4

    const-string v5, "iconst_1"

    invoke-direct {v1, v2, v5}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 38
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/4 v2, 0x5

    const-string v5, "iconst_2"

    invoke-direct {v1, v2, v5}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 39
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/4 v2, 0x6

    const-string v5, "iconst_3"

    invoke-direct {v1, v2, v5}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 40
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/4 v2, 0x7

    const-string v5, "iconst_4"

    invoke-direct {v1, v2, v5}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 41
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x8

    const-string v5, "iconst_5"

    invoke-direct {v1, v2, v5}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 42
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x9

    const-string v5, "lconst_0"

    invoke-direct {v1, v2, v5}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 43
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0xa

    const-string v5, "lconst_1"

    invoke-direct {v1, v2, v5}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 44
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0xb

    const-string v5, "fconst_0"

    invoke-direct {v1, v2, v5}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 45
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0xc

    const-string v5, "fconst_1"

    invoke-direct {v1, v2, v5}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 46
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0xd

    const-string v5, "fconst_2"

    invoke-direct {v1, v2, v5}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 47
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0xe

    const-string v5, "dconst_0"

    invoke-direct {v1, v2, v5}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 48
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0xf

    const-string v5, "dconst_1"

    invoke-direct {v1, v2, v5}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 49
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteForm;

    const/16 v2, 0x10

    const/4 v5, -0x1

    filled-new-array {v2, v5}, [I

    move-result-object v6

    const-string v7, "bipush"

    invoke-direct {v1, v2, v7, v6}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteForm;-><init>(ILjava/lang/String;[I)V

    aput-object v1, v0, v2

    .line 50
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ShortForm;

    const-string/jumbo v2, "sipush"

    const/16 v6, 0x11

    filled-new-array {v6, v5, v5}, [I

    move-result-object v7

    invoke-direct {v1, v6, v2, v7}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ShortForm;-><init>(ILjava/lang/String;[I)V

    aput-object v1, v0, v6

    .line 51
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/StringRefForm;

    const-string v2, "ldc"

    const/16 v6, 0x12

    filled-new-array {v6, v5}, [I

    move-result-object v7

    invoke-direct {v1, v6, v2, v7}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/StringRefForm;-><init>(ILjava/lang/String;[I)V

    aput-object v1, v0, v6

    .line 52
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/StringRefForm;

    const-string v2, "ldc_w"

    const/16 v7, 0x13

    filled-new-array {v7, v5, v5}, [I

    move-result-object v8

    invoke-direct {v1, v7, v2, v8, v4}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/StringRefForm;-><init>(ILjava/lang/String;[IZ)V

    aput-object v1, v0, v7

    .line 53
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LongForm;

    const-string v2, "ldc2_w"

    const/16 v8, 0x14

    filled-new-array {v8, v5, v5}, [I

    move-result-object v9

    invoke-direct {v1, v8, v2, v9}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LongForm;-><init>(ILjava/lang/String;[I)V

    aput-object v1, v0, v8

    .line 54
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LocalForm;

    const-string v2, "iload"

    const/16 v9, 0x15

    filled-new-array {v9, v5}, [I

    move-result-object v10

    invoke-direct {v1, v9, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LocalForm;-><init>(ILjava/lang/String;[I)V

    aput-object v1, v0, v9

    .line 55
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LocalForm;

    const-string v2, "lload"

    const/16 v9, 0x16

    filled-new-array {v9, v5}, [I

    move-result-object v10

    invoke-direct {v1, v9, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LocalForm;-><init>(ILjava/lang/String;[I)V

    aput-object v1, v0, v9

    .line 56
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LocalForm;

    const-string v2, "fload"

    const/16 v9, 0x17

    filled-new-array {v9, v5}, [I

    move-result-object v10

    invoke-direct {v1, v9, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LocalForm;-><init>(ILjava/lang/String;[I)V

    aput-object v1, v0, v9

    .line 57
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LocalForm;

    const-string v2, "dload"

    const/16 v9, 0x18

    filled-new-array {v9, v5}, [I

    move-result-object v10

    invoke-direct {v1, v9, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LocalForm;-><init>(ILjava/lang/String;[I)V

    aput-object v1, v0, v9

    .line 58
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LocalForm;

    const-string v2, "aload"

    const/16 v9, 0x19

    filled-new-array {v9, v5}, [I

    move-result-object v10

    invoke-direct {v1, v9, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LocalForm;-><init>(ILjava/lang/String;[I)V

    aput-object v1, v0, v9

    .line 59
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x1a

    const-string v9, "iload_0"

    invoke-direct {v1, v2, v9}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 60
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x1b

    const-string v9, "iload_1"

    invoke-direct {v1, v2, v9}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 61
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x1c

    const-string v9, "iload_2"

    invoke-direct {v1, v2, v9}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 62
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x1d

    const-string v9, "iload_3"

    invoke-direct {v1, v2, v9}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 63
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x1e

    const-string v9, "lload_0"

    invoke-direct {v1, v2, v9}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 64
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x1f

    const-string v9, "lload_1"

    invoke-direct {v1, v2, v9}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 65
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x20

    const-string v9, "lload_2"

    invoke-direct {v1, v2, v9}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 66
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x21

    const-string v9, "lload_3"

    invoke-direct {v1, v2, v9}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 67
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x22

    const-string v9, "fload_0"

    invoke-direct {v1, v2, v9}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 68
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x23

    const-string v9, "fload_1"

    invoke-direct {v1, v2, v9}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 69
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x24

    const-string v9, "fload_2"

    invoke-direct {v1, v2, v9}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 70
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x25

    const-string v9, "fload_3"

    invoke-direct {v1, v2, v9}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 71
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x26

    const-string v9, "dload_0"

    invoke-direct {v1, v2, v9}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 72
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x27

    const-string v9, "dload_1"

    invoke-direct {v1, v2, v9}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 73
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x28

    const-string v9, "dload_2"

    invoke-direct {v1, v2, v9}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 74
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x29

    const-string v9, "dload_3"

    invoke-direct {v1, v2, v9}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 75
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const-string v2, "aload_0"

    const/16 v9, 0x2a

    invoke-direct {v1, v9, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v9

    .line 76
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x2b

    const-string v10, "aload_1"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 77
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x2c

    const-string v10, "aload_2"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 78
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x2d

    const-string v10, "aload_3"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 79
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x2e

    const-string v10, "iaload"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 80
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x2f

    const-string v10, "laload"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 81
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x30

    const-string v10, "faload"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 82
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x31

    const-string v10, "daload"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 83
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x32

    const-string v10, "aaload"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 84
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x33

    const-string v10, "baload"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 85
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x34

    const-string v10, "caload"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 86
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x35

    const-string/jumbo v10, "saload"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 87
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LocalForm;

    const-string v2, "istore"

    const/16 v10, 0x36

    filled-new-array {v10, v5}, [I

    move-result-object v11

    invoke-direct {v1, v10, v2, v11}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LocalForm;-><init>(ILjava/lang/String;[I)V

    aput-object v1, v0, v10

    .line 88
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LocalForm;

    const/16 v2, 0x37

    filled-new-array {v2, v5}, [I

    move-result-object v2

    const/16 v10, 0x37

    const-string v11, "lstore"

    invoke-direct {v1, v10, v11, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LocalForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0x37

    aput-object v1, v0, v2

    .line 89
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LocalForm;

    const/16 v2, 0x38

    filled-new-array {v2, v5}, [I

    move-result-object v2

    const/16 v10, 0x38

    const-string v11, "fstore"

    invoke-direct {v1, v10, v11, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LocalForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0x38

    aput-object v1, v0, v2

    .line 90
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LocalForm;

    const/16 v2, 0x39

    filled-new-array {v2, v5}, [I

    move-result-object v2

    const/16 v10, 0x39

    const-string v11, "dstore"

    invoke-direct {v1, v10, v11, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LocalForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0x39

    aput-object v1, v0, v2

    .line 91
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LocalForm;

    const/16 v2, 0x3a

    filled-new-array {v2, v5}, [I

    move-result-object v2

    const/16 v10, 0x3a

    const-string v11, "astore"

    invoke-direct {v1, v10, v11, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LocalForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0x3a

    aput-object v1, v0, v2

    .line 92
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x3b

    const-string v10, "istore_0"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 93
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x3c

    const-string v10, "istore_1"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 94
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x3d

    const-string v10, "istore_2"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 95
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x3e

    const-string v10, "istore_3"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 96
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x3f

    const-string v10, "lstore_0"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 97
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x40

    const-string v10, "lstore_1"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 98
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x41

    const-string v10, "lstore_2"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 99
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x42

    const-string v10, "lstore_3"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 100
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x43

    const-string v10, "fstore_0"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 101
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x44

    const-string v10, "fstore_1"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 102
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x45

    const-string v10, "fstore_2"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 103
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x46

    const-string v10, "fstore_3"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 104
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x47

    const-string v10, "dstore_0"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 105
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x48

    const-string v10, "dstore_1"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 106
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x49

    const-string v10, "dstore_2"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 107
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x4a

    const-string v10, "dstore_3"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 108
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x4b

    const-string v10, "astore_0"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 109
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x4c

    const-string v10, "astore_1"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 110
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x4d

    const-string v10, "astore_2"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 111
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x4e

    const-string v10, "astore_3"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 112
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x4f

    const-string v10, "iastore"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 113
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x50

    const-string v10, "lastore"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 114
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x51

    const-string v10, "fastore"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 115
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x52

    const-string v10, "dastore"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 116
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x53

    const-string v10, "aastore"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 117
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x54

    const-string v10, "bastore"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 118
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x55

    const-string v10, "castore"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 119
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x56

    const-string/jumbo v10, "sastore"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 120
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x57

    const-string v10, "pop"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 121
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x58

    const-string v10, "pop2"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 122
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x59

    const-string v10, "dup"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 123
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x5a

    const-string v10, "dup_x1"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 124
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x5b

    const-string v10, "dup_x2"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 125
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x5c

    const-string v10, "dup2"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 126
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x5d

    const-string v10, "dup2_x1"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 127
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x5e

    const-string v10, "dup2_x2"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 128
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x5f

    const-string/jumbo v10, "swap"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 129
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x60

    const-string v10, "iadd"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 130
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x61

    const-string v10, "ladd"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 131
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x62

    const-string v10, "fadd"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 132
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x63

    const-string v10, "dadd"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 133
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x64

    const-string v10, "isub"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 134
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x65

    const-string v10, "lsub"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 135
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x66

    const-string v10, "fsub"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 136
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x67

    const-string v10, "dsub"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 137
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x68

    const-string v10, "imul"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 138
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x69

    const-string v10, "lmul"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 139
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x6a

    const-string v10, "fmul"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 140
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x6b

    const-string v10, "dmul"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 141
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x6c

    const-string v10, "idiv"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 142
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x6d

    const-string v10, "ldiv"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 143
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x6e

    const-string v10, "fdiv"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 144
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x6f

    const-string v10, "ddiv"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 145
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x70

    const-string v10, "irem"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 146
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x71

    const-string v10, "lrem"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 147
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x72

    const-string v10, "frem"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 148
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x73

    const-string v10, "drem"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 149
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x74

    const-string v10, ""

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 150
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x75

    const-string v10, "lneg"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 151
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x76

    const-string v10, "fneg"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 152
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x77

    const-string v10, "dneg"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 153
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x78

    const-string v10, "ishl"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 154
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x79

    const-string v10, "lshl"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 155
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x7a

    const-string v10, "ishr"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 156
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x7b

    const-string v10, "lshr"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 157
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x7c

    const-string v10, "iushr"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 158
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x7d

    const-string v10, "lushr"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 159
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x7e

    const-string v10, "iand"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 160
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x7f

    const-string v10, "land"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 161
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x80

    const-string v10, "ior"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 162
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x81

    const-string v10, "lor"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 163
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x82

    const-string v10, "ixor"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 164
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x83

    const-string v10, "lxor"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 165
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/IincForm;

    const/16 v2, 0x84

    filled-new-array {v2, v5, v5}, [I

    move-result-object v2

    const/16 v10, 0x84

    const-string v11, "iinc"

    invoke-direct {v1, v10, v11, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/IincForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0x84

    aput-object v1, v0, v2

    .line 166
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x85

    const-string v10, "i2l"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 167
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x86

    const-string v10, "i2f"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 168
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x87

    const-string v10, "i2d"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 169
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x88

    const-string v10, "l2i"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 170
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x89

    const-string v10, "l2f"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 171
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x8a

    const-string v10, "l2d"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 172
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x8b

    const-string v10, "f2i"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 173
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x8c

    const-string v10, "f2l"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 174
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x8d

    const-string v10, "f2d"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 175
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x8e

    const-string v10, "d2i"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 176
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x8f

    const-string v10, "d2l"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 177
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x90

    const-string v10, "d2f"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 178
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x91

    const-string v10, "i2b"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 179
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x92

    const-string v10, "i2c"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 180
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x93

    const-string v10, "i2s"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 181
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x94

    const-string v10, "lcmp"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 182
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x95

    const-string v10, "fcmpl"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 183
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x96

    const-string v10, "fcmpg"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 184
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x97

    const-string v10, "dcmpl"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 185
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0x98

    const-string v10, "dcmpg"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 186
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;

    const/16 v2, 0x99

    filled-new-array {v2, v5, v5}, [I

    move-result-object v2

    const/16 v10, 0x99

    const-string v11, "ifeq"

    invoke-direct {v1, v10, v11, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0x99

    aput-object v1, v0, v2

    .line 187
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;

    const/16 v2, 0x9a

    filled-new-array {v2, v5, v5}, [I

    move-result-object v2

    const/16 v10, 0x9a

    const-string v11, "ifne"

    invoke-direct {v1, v10, v11, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0x9a

    aput-object v1, v0, v2

    .line 188
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;

    const/16 v2, 0x9b

    filled-new-array {v2, v5, v5}, [I

    move-result-object v2

    const/16 v10, 0x9b

    const-string v11, "iflt"

    invoke-direct {v1, v10, v11, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0x9b

    aput-object v1, v0, v2

    .line 189
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;

    const/16 v2, 0x9c

    filled-new-array {v2, v5, v5}, [I

    move-result-object v2

    const/16 v10, 0x9c

    const-string v11, "ifge"

    invoke-direct {v1, v10, v11, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0x9c

    aput-object v1, v0, v2

    .line 190
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;

    const/16 v2, 0x9d

    filled-new-array {v2, v5, v5}, [I

    move-result-object v2

    const/16 v10, 0x9d

    const-string v11, "ifgt"

    invoke-direct {v1, v10, v11, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0x9d

    aput-object v1, v0, v2

    .line 191
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;

    const/16 v2, 0x9e

    filled-new-array {v2, v5, v5}, [I

    move-result-object v2

    const/16 v10, 0x9e

    const-string v11, "ifle"

    invoke-direct {v1, v10, v11, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0x9e

    aput-object v1, v0, v2

    .line 192
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;

    const/16 v2, 0x9f

    filled-new-array {v2, v5, v5}, [I

    move-result-object v2

    const/16 v10, 0x9f

    const-string v11, "if_icmpeq"

    invoke-direct {v1, v10, v11, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0x9f

    aput-object v1, v0, v2

    .line 193
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;

    const/16 v2, 0xa0

    filled-new-array {v2, v5, v5}, [I

    move-result-object v2

    const/16 v10, 0xa0

    const-string v11, "if_icmpne"

    invoke-direct {v1, v10, v11, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xa0

    aput-object v1, v0, v2

    .line 194
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;

    const/16 v2, 0xa1

    filled-new-array {v2, v5, v5}, [I

    move-result-object v2

    const/16 v10, 0xa1

    const-string v11, "if_icmplt"

    invoke-direct {v1, v10, v11, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xa1

    aput-object v1, v0, v2

    .line 195
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;

    const/16 v2, 0xa2

    filled-new-array {v2, v5, v5}, [I

    move-result-object v2

    const/16 v10, 0xa2

    const-string v11, "if_icmpge"

    invoke-direct {v1, v10, v11, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xa2

    aput-object v1, v0, v2

    .line 196
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;

    const/16 v2, 0xa3

    filled-new-array {v2, v5, v5}, [I

    move-result-object v2

    const/16 v10, 0xa3

    const-string v11, "if_icmpgt"

    invoke-direct {v1, v10, v11, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xa3

    aput-object v1, v0, v2

    .line 197
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;

    const/16 v2, 0xa4

    filled-new-array {v2, v5, v5}, [I

    move-result-object v2

    const/16 v10, 0xa4

    const-string v11, "if_icmple"

    invoke-direct {v1, v10, v11, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xa4

    aput-object v1, v0, v2

    .line 198
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;

    const/16 v2, 0xa5

    filled-new-array {v2, v5, v5}, [I

    move-result-object v2

    const/16 v10, 0xa5

    const-string v11, "if_acmpeq"

    invoke-direct {v1, v10, v11, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xa5

    aput-object v1, v0, v2

    .line 199
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;

    const/16 v2, 0xa6

    filled-new-array {v2, v5, v5}, [I

    move-result-object v2

    const/16 v10, 0xa6

    const-string v11, "if_acmpne"

    invoke-direct {v1, v10, v11, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xa6

    aput-object v1, v0, v2

    .line 200
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;

    const/16 v2, 0xa7

    filled-new-array {v2, v5, v5}, [I

    move-result-object v2

    const/16 v10, 0xa7

    const-string v11, "goto"

    invoke-direct {v1, v10, v11, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xa7

    aput-object v1, v0, v2

    .line 201
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;

    const/16 v2, 0xa8

    filled-new-array {v2, v5, v5}, [I

    move-result-object v2

    const/16 v10, 0xa8

    const-string v11, "jsr"

    invoke-direct {v1, v10, v11, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xa8

    aput-object v1, v0, v2

    .line 202
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LocalForm;

    const/16 v2, 0xa9

    filled-new-array {v2, v5}, [I

    move-result-object v2

    const/16 v10, 0xa9

    const-string v11, "ret"

    invoke-direct {v1, v10, v11, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LocalForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xa9

    aput-object v1, v0, v2

    .line 203
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/TableSwitchForm;

    const/16 v2, 0xaa

    const-string/jumbo v10, "tableswitch"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/TableSwitchForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 204
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LookupSwitchForm;

    const/16 v2, 0xab

    const-string v10, "lookupswitch"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LookupSwitchForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 205
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0xac

    const-string v10, "ireturn"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 206
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0xad

    const-string v10, "lreturn"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 207
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0xae

    const-string v10, "freturn"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 208
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0xaf

    const-string v10, "dreturn"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 209
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0xb0

    const-string v10, "areturn"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 210
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0xb1

    const-string v10, "return"

    invoke-direct {v1, v2, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 211
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/FieldRefForm;

    const-string v2, "getstatic"

    const/16 v10, 0xb2

    filled-new-array {v10, v5, v5}, [I

    move-result-object v11

    invoke-direct {v1, v10, v2, v11}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/FieldRefForm;-><init>(ILjava/lang/String;[I)V

    aput-object v1, v0, v10

    .line 212
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/FieldRefForm;

    const-string v2, "putstatic"

    const/16 v11, 0xb3

    filled-new-array {v11, v5, v5}, [I

    move-result-object v12

    invoke-direct {v1, v11, v2, v12}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/FieldRefForm;-><init>(ILjava/lang/String;[I)V

    aput-object v1, v0, v11

    .line 213
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/FieldRefForm;

    const-string v2, "getfield"

    const/16 v12, 0xb4

    filled-new-array {v12, v5, v5}, [I

    move-result-object v13

    invoke-direct {v1, v12, v2, v13}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/FieldRefForm;-><init>(ILjava/lang/String;[I)V

    aput-object v1, v0, v12

    .line 214
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/FieldRefForm;

    const-string v2, "putfield"

    const/16 v13, 0xb5

    filled-new-array {v13, v5, v5}, [I

    move-result-object v14

    invoke-direct {v1, v13, v2, v14}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/FieldRefForm;-><init>(ILjava/lang/String;[I)V

    aput-object v1, v0, v13

    .line 215
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/MethodRefForm;

    const-string v2, "invokevirtual"

    const/16 v14, 0xb6

    filled-new-array {v14, v5, v5}, [I

    move-result-object v15

    invoke-direct {v1, v14, v2, v15}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/MethodRefForm;-><init>(ILjava/lang/String;[I)V

    aput-object v1, v0, v14

    .line 216
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/MethodRefForm;

    const-string v2, "invokespecial"

    const/16 v15, 0xb7

    filled-new-array {v15, v5, v5}, [I

    move-result-object v8

    invoke-direct {v1, v15, v2, v8}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/MethodRefForm;-><init>(ILjava/lang/String;[I)V

    aput-object v1, v0, v15

    .line 217
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/MethodRefForm;

    const-string v2, "invokestatic"

    const/16 v8, 0xb8

    filled-new-array {v8, v5, v5}, [I

    move-result-object v7

    invoke-direct {v1, v8, v2, v7}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/MethodRefForm;-><init>(ILjava/lang/String;[I)V

    aput-object v1, v0, v8

    .line 218
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/IMethodRefForm;

    const/16 v2, 0xb9

    filled-new-array {v2, v5, v5, v5, v3}, [I

    move-result-object v2

    const/16 v3, 0xb9

    const-string v7, "invokeinterface"

    invoke-direct {v1, v3, v7, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/IMethodRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xb9

    aput-object v1, v0, v2

    .line 219
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0xba

    const-string/jumbo v3, "xxxunusedxxx"

    invoke-direct {v1, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 220
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NewClassRefForm;

    const/16 v2, 0xbb

    filled-new-array {v2, v5, v5}, [I

    move-result-object v2

    const/16 v3, 0xbb

    const-string v7, "new"

    invoke-direct {v1, v3, v7, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NewClassRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xbb

    aput-object v1, v0, v2

    .line 221
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteForm;

    const/16 v2, 0xbc

    filled-new-array {v2, v5}, [I

    move-result-object v2

    const/16 v3, 0xbc

    const-string v7, "newarray"

    invoke-direct {v1, v3, v7, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xbc

    aput-object v1, v0, v2

    .line 222
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ClassRefForm;

    const/16 v2, 0xbd

    filled-new-array {v2, v5, v5}, [I

    move-result-object v2

    const/16 v3, 0xbd

    const-string v7, "anewarray"

    invoke-direct {v1, v3, v7, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ClassRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xbd

    aput-object v1, v0, v2

    .line 223
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0xbe

    const-string v3, "arraylength"

    invoke-direct {v1, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 224
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0xbf

    const-string v3, "athrow"

    invoke-direct {v1, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 225
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ClassRefForm;

    const/16 v2, 0xc0

    filled-new-array {v2, v5, v5}, [I

    move-result-object v2

    const/16 v3, 0xc0

    const-string v7, "checkcast"

    invoke-direct {v1, v3, v7, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ClassRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xc0

    aput-object v1, v0, v2

    .line 226
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ClassRefForm;

    const/16 v2, 0xc1

    filled-new-array {v2, v5, v5}, [I

    move-result-object v2

    const/16 v3, 0xc1

    const-string v7, "instanceof"

    invoke-direct {v1, v3, v7, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ClassRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xc1

    aput-object v1, v0, v2

    .line 227
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0xc2

    const-string v3, "monitorenter"

    invoke-direct {v1, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 228
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0xc3

    const-string v3, "monitorexit"

    invoke-direct {v1, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 229
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/WideForm;

    const/16 v2, 0xc4

    const-string/jumbo v3, "wide"

    invoke-direct {v1, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/WideForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 230
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/MultiANewArrayForm;

    const/16 v2, 0xc5

    filled-new-array {v2, v5, v5, v5}, [I

    move-result-object v2

    const/16 v3, 0xc5

    const-string v7, "multianewarray"

    invoke-direct {v1, v3, v7, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/MultiANewArrayForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xc5

    aput-object v1, v0, v2

    .line 231
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;

    const/16 v2, 0xc6

    filled-new-array {v2, v5, v5}, [I

    move-result-object v2

    const/16 v3, 0xc6

    const-string v7, "ifnull"

    invoke-direct {v1, v3, v7, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xc6

    aput-object v1, v0, v2

    .line 232
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;

    const/16 v2, 0xc7

    filled-new-array {v2, v5, v5}, [I

    move-result-object v2

    const/16 v3, 0xc7

    const-string v7, "ifnonnull"

    invoke-direct {v1, v3, v7, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xc7

    aput-object v1, v0, v2

    .line 233
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;

    const/16 v2, 0xc8

    filled-new-array {v2, v5, v5, v5, v5}, [I

    move-result-object v2

    const/16 v3, 0xc8

    const-string v7, "goto_w"

    invoke-direct {v1, v3, v7, v2, v4}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;-><init>(ILjava/lang/String;[IZ)V

    const/16 v2, 0xc8

    aput-object v1, v0, v2

    .line 234
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;

    const/16 v2, 0xc9

    filled-new-array {v2, v5, v5, v5, v5}, [I

    move-result-object v2

    const/16 v3, 0xc9

    const-string v7, "jsr_w"

    invoke-direct {v1, v3, v7, v2, v4}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LabelForm;-><init>(ILjava/lang/String;[IZ)V

    const/16 v2, 0xc9

    aput-object v1, v0, v2

    .line 237
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ThisFieldRefForm;

    const-string v2, "getstatic_this"

    filled-new-array {v10, v5, v5}, [I

    move-result-object v3

    const/16 v7, 0xca

    invoke-direct {v1, v7, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ThisFieldRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xca

    aput-object v1, v0, v2

    .line 238
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ThisFieldRefForm;

    const-string v2, "putstatic_this"

    filled-new-array {v11, v5, v5}, [I

    move-result-object v3

    const/16 v7, 0xcb

    invoke-direct {v1, v7, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ThisFieldRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xcb

    aput-object v1, v0, v2

    .line 239
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ThisFieldRefForm;

    const-string v2, "getfield_this"

    filled-new-array {v12, v5, v5}, [I

    move-result-object v3

    const/16 v7, 0xcc

    invoke-direct {v1, v7, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ThisFieldRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xcc

    aput-object v1, v0, v2

    .line 240
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ThisFieldRefForm;

    const-string v2, "putfield_this"

    filled-new-array {v13, v5, v5}, [I

    move-result-object v3

    const/16 v7, 0xcd

    invoke-direct {v1, v7, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ThisFieldRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xcd

    aput-object v1, v0, v2

    .line 241
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ThisMethodRefForm;

    const-string v2, "invokevirtual_this"

    filled-new-array {v14, v5, v5}, [I

    move-result-object v3

    const/16 v7, 0xce

    invoke-direct {v1, v7, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ThisMethodRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xce

    aput-object v1, v0, v2

    .line 242
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ThisMethodRefForm;

    const-string v2, "invokespecial_this"

    filled-new-array {v15, v5, v5}, [I

    move-result-object v3

    const/16 v7, 0xcf

    invoke-direct {v1, v7, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ThisMethodRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xcf

    aput-object v1, v0, v2

    .line 243
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ThisMethodRefForm;

    const-string v2, "invokestatic_this"

    filled-new-array {v8, v5, v5}, [I

    move-result-object v3

    const/16 v7, 0xd0

    invoke-direct {v1, v7, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ThisMethodRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xd0

    aput-object v1, v0, v2

    .line 244
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ThisFieldRefForm;

    const-string v2, "aload_0_getstatic_this"

    filled-new-array {v9, v10, v5, v5}, [I

    move-result-object v3

    const/16 v7, 0xd1

    invoke-direct {v1, v7, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ThisFieldRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xd1

    aput-object v1, v0, v2

    .line 245
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ThisFieldRefForm;

    const-string v2, "aload_0_putstatic_this"

    filled-new-array {v9, v11, v5, v5}, [I

    move-result-object v3

    const/16 v7, 0xd2

    invoke-direct {v1, v7, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ThisFieldRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xd2

    aput-object v1, v0, v2

    .line 246
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ThisFieldRefForm;

    const-string v2, "aload_0_getfield_this"

    filled-new-array {v9, v12, v5, v5}, [I

    move-result-object v3

    const/16 v7, 0xd3

    invoke-direct {v1, v7, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ThisFieldRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xd3

    aput-object v1, v0, v2

    .line 247
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ThisFieldRefForm;

    const-string v2, "aload_0_putfield_this"

    filled-new-array {v9, v13, v5, v5}, [I

    move-result-object v3

    const/16 v7, 0xd4

    invoke-direct {v1, v7, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ThisFieldRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xd4

    aput-object v1, v0, v2

    .line 248
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ThisMethodRefForm;

    const-string v2, "aload_0_invokevirtual_this"

    filled-new-array {v9, v14, v5, v5}, [I

    move-result-object v3

    const/16 v7, 0xd5

    invoke-direct {v1, v7, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ThisMethodRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xd5

    aput-object v1, v0, v2

    .line 249
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ThisMethodRefForm;

    const-string v2, "aload_0_invokespecial_this"

    filled-new-array {v9, v15, v5, v5}, [I

    move-result-object v3

    const/16 v7, 0xd6

    invoke-direct {v1, v7, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ThisMethodRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xd6

    aput-object v1, v0, v2

    .line 250
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ThisMethodRefForm;

    const-string v2, "aload_0_invokestatic_this"

    filled-new-array {v9, v8, v5, v5}, [I

    move-result-object v3

    const/16 v7, 0xd7

    invoke-direct {v1, v7, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ThisMethodRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xd7

    aput-object v1, v0, v2

    .line 251
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/SuperFieldRefForm;

    const-string v2, "getstatic_super"

    filled-new-array {v10, v5, v5}, [I

    move-result-object v3

    const/16 v7, 0xd8

    invoke-direct {v1, v7, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/SuperFieldRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xd8

    aput-object v1, v0, v2

    .line 252
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/SuperFieldRefForm;

    const-string v2, "putstatic_super"

    filled-new-array {v11, v5, v5}, [I

    move-result-object v3

    const/16 v7, 0xd9

    invoke-direct {v1, v7, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/SuperFieldRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xd9

    aput-object v1, v0, v2

    .line 253
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/SuperFieldRefForm;

    const-string v2, "getfield_super"

    filled-new-array {v12, v5, v5}, [I

    move-result-object v3

    const/16 v7, 0xda

    invoke-direct {v1, v7, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/SuperFieldRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xda

    aput-object v1, v0, v2

    .line 254
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/SuperFieldRefForm;

    const-string v2, "putfield_super"

    filled-new-array {v13, v5, v5}, [I

    move-result-object v3

    const/16 v7, 0xdb

    invoke-direct {v1, v7, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/SuperFieldRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xdb

    aput-object v1, v0, v2

    .line 255
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/SuperMethodRefForm;

    const-string v2, "invokevirtual_super"

    filled-new-array {v14, v5, v5}, [I

    move-result-object v3

    const/16 v7, 0xdc

    invoke-direct {v1, v7, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/SuperMethodRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xdc

    aput-object v1, v0, v2

    .line 256
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/SuperMethodRefForm;

    const-string v2, "invokespecial_super"

    filled-new-array {v15, v5, v5}, [I

    move-result-object v3

    const/16 v7, 0xdd

    invoke-direct {v1, v7, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/SuperMethodRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xdd

    aput-object v1, v0, v2

    .line 257
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/SuperMethodRefForm;

    const-string v2, "invokestatic_super"

    filled-new-array {v8, v5, v5}, [I

    move-result-object v3

    const/16 v7, 0xde

    invoke-direct {v1, v7, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/SuperMethodRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xde

    aput-object v1, v0, v2

    .line 258
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/SuperFieldRefForm;

    const-string v2, "aload_0_getstatic_super"

    filled-new-array {v9, v10, v5, v5}, [I

    move-result-object v3

    const/16 v7, 0xdf

    invoke-direct {v1, v7, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/SuperFieldRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xdf

    aput-object v1, v0, v2

    .line 259
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/SuperFieldRefForm;

    const-string v2, "aload_0_putstatic_super"

    filled-new-array {v9, v11, v5, v5}, [I

    move-result-object v3

    const/16 v7, 0xe0

    invoke-direct {v1, v7, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/SuperFieldRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xe0

    aput-object v1, v0, v2

    .line 260
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/SuperFieldRefForm;

    const-string v2, "aload_0_getfield_super"

    filled-new-array {v9, v12, v5, v5}, [I

    move-result-object v3

    const/16 v7, 0xe1

    invoke-direct {v1, v7, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/SuperFieldRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xe1

    aput-object v1, v0, v2

    .line 261
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/SuperFieldRefForm;

    const-string v2, "aload_0_putfield_super"

    filled-new-array {v9, v13, v5, v5}, [I

    move-result-object v3

    const/16 v7, 0xe2

    invoke-direct {v1, v7, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/SuperFieldRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xe2

    aput-object v1, v0, v2

    .line 262
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/SuperMethodRefForm;

    const-string v2, "aload_0_invokevirtual_super"

    filled-new-array {v9, v14, v5, v5}, [I

    move-result-object v3

    const/16 v7, 0xe3

    invoke-direct {v1, v7, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/SuperMethodRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xe3

    aput-object v1, v0, v2

    .line 263
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/SuperMethodRefForm;

    const-string v2, "aload_0_invokespecial_super"

    filled-new-array {v9, v15, v5, v5}, [I

    move-result-object v3

    const/16 v7, 0xe4

    invoke-direct {v1, v7, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/SuperMethodRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xe4

    aput-object v1, v0, v2

    .line 264
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/SuperMethodRefForm;

    const-string v2, "aload_0_invokestatic_super"

    filled-new-array {v9, v8, v5, v5}, [I

    move-result-object v3

    const/16 v7, 0xe5

    invoke-direct {v1, v7, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/SuperMethodRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xe5

    aput-object v1, v0, v2

    .line 265
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ThisInitMethodRefForm;

    const-string v2, "invokespecial_this_init"

    filled-new-array {v15, v5, v5}, [I

    move-result-object v3

    const/16 v7, 0xe6

    invoke-direct {v1, v7, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ThisInitMethodRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xe6

    aput-object v1, v0, v2

    .line 266
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/SuperInitMethodRefForm;

    const-string v2, "invokespecial_super_init"

    filled-new-array {v15, v5, v5}, [I

    move-result-object v3

    const/16 v7, 0xe7

    invoke-direct {v1, v7, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/SuperInitMethodRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xe7

    aput-object v1, v0, v2

    .line 267
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NewInitMethodRefForm;

    const-string v2, "invokespecial_new_init"

    filled-new-array {v15, v5, v5}, [I

    move-result-object v3

    const/16 v7, 0xe8

    invoke-direct {v1, v7, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NewInitMethodRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xe8

    aput-object v1, v0, v2

    .line 268
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NarrowClassRefForm;

    const-string v2, "cldc"

    filled-new-array {v6, v5}, [I

    move-result-object v3

    const/16 v7, 0xe9

    invoke-direct {v1, v7, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NarrowClassRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xe9

    aput-object v1, v0, v2

    .line 269
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/IntRefForm;

    const-string v2, "ildc"

    filled-new-array {v6, v5}, [I

    move-result-object v3

    const/16 v7, 0xea

    invoke-direct {v1, v7, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/IntRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xea

    aput-object v1, v0, v2

    .line 270
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/FloatRefForm;

    const-string v2, "fldc"

    filled-new-array {v6, v5}, [I

    move-result-object v3

    const/16 v6, 0xeb

    invoke-direct {v1, v6, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/FloatRefForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xeb

    aput-object v1, v0, v2

    .line 271
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NarrowClassRefForm;

    const-string v2, "cldc_w"

    const/16 v3, 0x13

    filled-new-array {v3, v5, v5}, [I

    move-result-object v6

    const/16 v7, 0xec

    invoke-direct {v1, v7, v2, v6, v4}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NarrowClassRefForm;-><init>(ILjava/lang/String;[IZ)V

    const/16 v2, 0xec

    aput-object v1, v0, v2

    .line 272
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/IntRefForm;

    const-string v2, "ildc_w"

    filled-new-array {v3, v5, v5}, [I

    move-result-object v6

    const/16 v7, 0xed

    invoke-direct {v1, v7, v2, v6, v4}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/IntRefForm;-><init>(ILjava/lang/String;[IZ)V

    const/16 v2, 0xed

    aput-object v1, v0, v2

    .line 273
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/FloatRefForm;

    const-string v2, "fldc_w"

    filled-new-array {v3, v5, v5}, [I

    move-result-object v3

    const/16 v6, 0xee

    invoke-direct {v1, v6, v2, v3, v4}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/FloatRefForm;-><init>(ILjava/lang/String;[IZ)V

    const/16 v2, 0xee

    aput-object v1, v0, v2

    .line 274
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/DoubleForm;

    const-string v2, "dldc2_w"

    const/16 v3, 0x14

    filled-new-array {v3, v5, v5}, [I

    move-result-object v3

    const/16 v4, 0xef

    invoke-direct {v1, v4, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/DoubleForm;-><init>(ILjava/lang/String;[I)V

    const/16 v2, 0xef

    aput-object v1, v0, v2

    .line 277
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0xfe

    const-string v3, "impdep1"

    invoke-direct {v1, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 278
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;

    const/16 v2, 0xff

    const-string v3, "impdep2"

    invoke-direct {v1, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/NoArgumentForm;-><init>(ILjava/lang/String;)V

    aput-object v1, v0, v2

    .line 286
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    sget-object v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    array-length v1, v1

    if-ge v0, v1, :cond_1

    .line 287
    sget-object v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    aget-object v1, v1, v0

    .line 288
    .local v1, "byteCode":Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;
    if-eqz v1, :cond_0

    .line 289
    sget-object v2, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodesByName:Ljava/util/Map;

    invoke-virtual {v1}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2, v3, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 286
    .end local v1    # "byteCode":Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 292
    .end local v0    # "i":I
    :cond_1
    return-void
.end method

.method public constructor <init>(ILjava/lang/String;)V
    .locals 1
    .param p1, "opcode"    # I
    .param p2, "name"    # Ljava/lang/String;

    .line 307
    filled-new-array {p1}, [I

    move-result-object v0

    invoke-direct {p0, p1, p2, v0}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;-><init>(ILjava/lang/String;[I)V

    .line 308
    return-void
.end method

.method public constructor <init>(ILjava/lang/String;[I)V
    .locals 0
    .param p1, "opcode"    # I
    .param p2, "name"    # Ljava/lang/String;
    .param p3, "rewrite"    # [I

    .line 318
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 319
    iput p1, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->opcode:I

    .line 320
    iput-object p2, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->name:Ljava/lang/String;

    .line 321
    iput-object p3, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->rewrite:[I

    .line 322
    invoke-virtual {p0}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->calculateOperandPosition()V

    .line 323
    return-void
.end method

.method public static get(I)Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;
    .locals 1
    .param p0, "opcode"    # I

    .line 367
    sget-object v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->byteCodeArray:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;

    aget-object v0, v0, p0

    return-object v0
.end method


# virtual methods
.method protected calculateOperandPosition()V
    .locals 5

    .line 326
    const/4 v0, -0x1

    iput v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->firstOperandIndex:I

    .line 327
    iput v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->operandLength:I

    .line 330
    const/4 v1, 0x0

    .line 331
    .local v1, "iterationIndex":I
    :goto_0
    iget-object v2, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->rewrite:[I

    array-length v2, v2

    if-ge v1, v2, :cond_1

    .line 332
    iget-object v2, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->rewrite:[I

    aget v2, v2, v1

    if-gez v2, :cond_0

    .line 334
    iput v1, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->firstOperandIndex:I

    .line 335
    iget-object v2, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->rewrite:[I

    array-length v1, v2

    goto :goto_0

    .line 337
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 341
    :cond_1
    iget v2, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->firstOperandIndex:I

    if-ne v2, v0, :cond_2

    .line 343
    return-void

    .line 347
    :cond_2
    const/4 v0, -0x1

    .line 348
    .local v0, "lastOperandIndex":I
    iget v1, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->firstOperandIndex:I

    .line 349
    :goto_1
    iget-object v2, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->rewrite:[I

    array-length v2, v2

    if-ge v1, v2, :cond_4

    .line 350
    iget-object v2, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->rewrite:[I

    aget v2, v2, v1

    if-gez v2, :cond_3

    .line 351
    move v0, v1

    .line 353
    :cond_3
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 357
    :cond_4
    iget v2, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->firstOperandIndex:I

    sub-int v2, v0, v2

    .line 360
    .local v2, "difference":I
    if-ltz v2, :cond_5

    .line 363
    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->operandLength:I

    .line 364
    return-void

    .line 361
    :cond_5
    new-instance v3, Ljava/lang/Error;

    const-string v4, "Logic error: not finding rewrite operands correctly"

    invoke-direct {v3, v4}, Ljava/lang/Error;-><init>(Ljava/lang/String;)V

    throw v3
.end method

.method public firstOperandIndex()I
    .locals 1

    .line 394
    iget v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->firstOperandIndex:I

    return v0
.end method

.method public fixUpByteCodeTargets(Lorg/apache/commons/compress/harmony/unpack200/bytecode/ByteCode;Lorg/apache/commons/compress/harmony/unpack200/bytecode/CodeAttribute;)V
    .locals 0
    .param p1, "byteCode"    # Lorg/apache/commons/compress/harmony/unpack200/bytecode/ByteCode;
    .param p2, "codeAttribute"    # Lorg/apache/commons/compress/harmony/unpack200/bytecode/CodeAttribute;

    .line 442
    return-void
.end method

.method public getName()Ljava/lang/String;
    .locals 1

    .line 380
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->name:Ljava/lang/String;

    return-object v0
.end method

.method public getOpcode()I
    .locals 1

    .line 376
    iget v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->opcode:I

    return v0
.end method

.method public getRewrite()[I
    .locals 1

    .line 384
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->rewrite:[I

    return-object v0
.end method

.method public getRewriteCopy()[I
    .locals 4

    .line 388
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->rewrite:[I

    array-length v0, v0

    new-array v0, v0, [I

    .line 389
    .local v0, "result":[I
    iget-object v1, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->rewrite:[I

    iget-object v2, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->rewrite:[I

    array-length v2, v2

    const/4 v3, 0x0

    invoke-static {v1, v3, v0, v3, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 390
    return-object v0
.end method

.method public hasMultipleByteCodes()Z
    .locals 4

    .line 414
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->rewrite:[I

    array-length v0, v0

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-le v0, v2, :cond_1

    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->rewrite:[I

    aget v0, v0, v1

    const/16 v3, 0x2a

    if-ne v0, v3, :cond_1

    .line 418
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->rewrite:[I

    aget v0, v0, v2

    if-lez v0, :cond_0

    move v1, v2

    :cond_0
    return v1

    .line 420
    :cond_1
    return v1
.end method

.method public hasNoOperand()Z
    .locals 1

    .line 402
    const/4 v0, 0x0

    return v0
.end method

.method public nestedMustStartClassPool()Z
    .locals 1

    .line 446
    const/4 v0, 0x0

    return v0
.end method

.method public operandLength()I
    .locals 1

    .line 398
    iget v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->operandLength:I

    return v0
.end method

.method public abstract setByteCodeOperands(Lorg/apache/commons/compress/harmony/unpack200/bytecode/ByteCode;Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;I)V
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 372
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/ByteCodeForm;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
