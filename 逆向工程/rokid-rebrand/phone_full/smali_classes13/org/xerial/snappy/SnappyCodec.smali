.class public Lorg/xerial/snappy/SnappyCodec;
.super Ljava/lang/Object;
.source "SnappyCodec.java"


# static fields
.field static final synthetic $assertionsDisabled:Z = false

.field public static final DEFAULT_VERSION:I = 0x1

.field public static final HEADER_SIZE:I

.field static final MAGIC_HEADER:[B

.field public static final MAGIC_HEADER_HEAD:I

.field public static final MAGIC_LEN:I

.field public static final MINIMUM_COMPATIBLE_VERSION:I = 0x1

.field public static final currentHeader:Lorg/xerial/snappy/SnappyCodec;


# instance fields
.field public final compatibleVersion:I

.field private final headerArray:[B

.field public final magic:[B

.field public final version:I


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 49
    nop

    .line 51
    const/16 v0, 0x8

    new-array v1, v0, [B

    fill-array-data v1, :array_0

    sput-object v1, Lorg/xerial/snappy/SnappyCodec;->MAGIC_HEADER:[B

    .line 52
    sget-object v1, Lorg/xerial/snappy/SnappyCodec;->MAGIC_HEADER:[B

    array-length v1, v1

    sput v1, Lorg/xerial/snappy/SnappyCodec;->MAGIC_LEN:I

    .line 53
    sget v1, Lorg/xerial/snappy/SnappyCodec;->MAGIC_LEN:I

    add-int/2addr v1, v0

    sput v1, Lorg/xerial/snappy/SnappyCodec;->HEADER_SIZE:I

    .line 54
    sget-object v0, Lorg/xerial/snappy/SnappyCodec;->MAGIC_HEADER:[B

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lorg/xerial/snappy/SnappyOutputStream;->readInt([BI)I

    move-result v0

    sput v0, Lorg/xerial/snappy/SnappyCodec;->MAGIC_HEADER_HEAD:I

    .line 57
    sget v0, Lorg/xerial/snappy/SnappyCodec;->MAGIC_HEADER_HEAD:I

    if-gez v0, :cond_0

    .line 62
    new-instance v0, Lorg/xerial/snappy/SnappyCodec;

    sget-object v1, Lorg/xerial/snappy/SnappyCodec;->MAGIC_HEADER:[B

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2, v2}, Lorg/xerial/snappy/SnappyCodec;-><init>([BII)V

    sput-object v0, Lorg/xerial/snappy/SnappyCodec;->currentHeader:Lorg/xerial/snappy/SnappyCodec;

    return-void

    .line 57
    :cond_0
    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    :array_0
    .array-data 1
        -0x7et
        0x53t
        0x4et
        0x41t
        0x50t
        0x50t
        0x59t
        0x0t
    .end array-data
.end method

.method private constructor <init>([BII)V
    .locals 4

    .line 70
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 71
    iput-object p1, p0, Lorg/xerial/snappy/SnappyCodec;->magic:[B

    .line 72
    iput p2, p0, Lorg/xerial/snappy/SnappyCodec;->version:I

    .line 73
    iput p3, p0, Lorg/xerial/snappy/SnappyCodec;->compatibleVersion:I

    .line 75
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    sget v1, Lorg/xerial/snappy/SnappyCodec;->HEADER_SIZE:I

    invoke-direct {v0, v1}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 76
    new-instance v1, Ljava/io/DataOutputStream;

    invoke-direct {v1, v0}, Ljava/io/DataOutputStream;-><init>(Ljava/io/OutputStream;)V

    .line 78
    :try_start_0
    sget v2, Lorg/xerial/snappy/SnappyCodec;->MAGIC_LEN:I

    const/4 v3, 0x0

    invoke-virtual {v1, p1, v3, v2}, Ljava/io/DataOutputStream;->write([BII)V

    .line 79
    invoke-virtual {v1, p2}, Ljava/io/DataOutputStream;->writeInt(I)V

    .line 80
    invoke-virtual {v1, p3}, Ljava/io/DataOutputStream;->writeInt(I)V

    .line 81
    invoke-virtual {v1}, Ljava/io/DataOutputStream;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 85
    nop

    .line 86
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object p1

    iput-object p1, p0, Lorg/xerial/snappy/SnappyCodec;->headerArray:[B

    .line 87
    return-void

    .line 83
    :catch_0
    move-exception p1

    .line 84
    new-instance p2, Ljava/lang/RuntimeException;

    invoke-direct {p2, p1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw p2
.end method

.method public static getMagicHeader()[B
    .locals 1

    .line 91
    sget-object v0, Lorg/xerial/snappy/SnappyCodec;->MAGIC_HEADER:[B

    invoke-virtual {v0}, [B->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [B

    return-object v0
.end method

.method public static hasMagicHeaderPrefix([B)Z
    .locals 5

    .line 124
    sget v0, Lorg/xerial/snappy/SnappyCodec;->MAGIC_LEN:I

    array-length v1, p0

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 125
    const/4 v1, 0x0

    move v2, v1

    .line 126
    :goto_0
    if-ge v2, v0, :cond_1

    .line 127
    aget-byte v3, p0, v2

    sget-object v4, Lorg/xerial/snappy/SnappyCodec;->MAGIC_HEADER:[B

    aget-byte v4, v4, v2

    if-eq v3, v4, :cond_0

    .line 128
    return v1

    .line 130
    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 132
    :cond_1
    const/4 p0, 0x1

    return p0
.end method

.method public static headerSize()I
    .locals 1

    .line 102
    sget v0, Lorg/xerial/snappy/SnappyCodec;->HEADER_SIZE:I

    return v0
.end method

.method public static readHeader(Ljava/io/InputStream;)Lorg/xerial/snappy/SnappyCodec;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 138
    new-instance v0, Ljava/io/DataInputStream;

    invoke-direct {v0, p0}, Ljava/io/DataInputStream;-><init>(Ljava/io/InputStream;)V

    .line 139
    sget p0, Lorg/xerial/snappy/SnappyCodec;->MAGIC_LEN:I

    new-array p0, p0, [B

    .line 140
    const/4 v1, 0x0

    sget v2, Lorg/xerial/snappy/SnappyCodec;->MAGIC_LEN:I

    invoke-virtual {v0, p0, v1, v2}, Ljava/io/DataInputStream;->readFully([BII)V

    .line 141
    invoke-virtual {v0}, Ljava/io/DataInputStream;->readInt()I

    move-result v1

    .line 142
    invoke-virtual {v0}, Ljava/io/DataInputStream;->readInt()I

    move-result v0

    .line 143
    new-instance v2, Lorg/xerial/snappy/SnappyCodec;

    invoke-direct {v2, p0, v1, v0}, Lorg/xerial/snappy/SnappyCodec;-><init>([BII)V

    return-object v2
.end method


# virtual methods
.method public isValidMagicHeader()Z
    .locals 2

    .line 120
    sget-object v0, Lorg/xerial/snappy/SnappyCodec;->MAGIC_HEADER:[B

    iget-object v1, p0, Lorg/xerial/snappy/SnappyCodec;->magic:[B

    invoke-static {v0, v1}, Ljava/util/Arrays;->equals([B[B)Z

    move-result v0

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 97
    iget v0, p0, Lorg/xerial/snappy/SnappyCodec;->version:I

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    iget v1, p0, Lorg/xerial/snappy/SnappyCodec;->compatibleVersion:I

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    filled-new-array {v0, v1}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "version:%d, compatible version:%d"

    invoke-static {v1, v0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public writeHeader(Ljava/io/OutputStream;)I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 114
    iget-object v0, p0, Lorg/xerial/snappy/SnappyCodec;->headerArray:[B

    iget-object v1, p0, Lorg/xerial/snappy/SnappyCodec;->headerArray:[B

    array-length v1, v1

    const/4 v2, 0x0

    invoke-virtual {p1, v0, v2, v1}, Ljava/io/OutputStream;->write([BII)V

    .line 115
    iget-object p1, p0, Lorg/xerial/snappy/SnappyCodec;->headerArray:[B

    array-length p1, p1

    return p1
.end method

.method public writeHeader([BI)I
    .locals 3

    .line 107
    iget-object v0, p0, Lorg/xerial/snappy/SnappyCodec;->headerArray:[B

    iget-object v1, p0, Lorg/xerial/snappy/SnappyCodec;->headerArray:[B

    array-length v1, v1

    const/4 v2, 0x0

    invoke-static {v0, v2, p1, p2, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 108
    iget-object p1, p0, Lorg/xerial/snappy/SnappyCodec;->headerArray:[B

    array-length p1, p1

    return p1
.end method
