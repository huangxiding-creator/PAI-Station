.class public Lcom/alibaba/sdk/android/oss/common/utils/CRC64;
.super Ljava/lang/Object;
.source "CRC64.java"

# interfaces
.implements Ljava/util/zip/Checksum;


# static fields
.field private static final GF2_DIM:I = 0x40

.field private static final POLY:J = -0x3693a86a2878f0beL

.field private static final table:[[J


# instance fields
.field private value:J


# direct methods
.method static constructor <clinit>()V
    .locals 12

    .line 19
    const/4 v0, 0x2

    new-array v0, v0, [I

    const/4 v1, 0x1

    const/16 v2, 0x100

    aput v2, v0, v1

    const/4 v3, 0x0

    const/16 v4, 0x8

    aput v4, v0, v3

    sget-object v5, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    invoke-static {v5, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [[J

    sput-object v0, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->table:[[J

    .line 21
    const/4 v0, 0x0

    .local v0, "n":I
    :goto_0
    if-ge v0, v2, :cond_2

    .line 22
    int-to-long v5, v0

    .line 23
    .local v5, "crc":J
    const/4 v7, 0x0

    .local v7, "k":I
    :goto_1
    if-ge v7, v4, :cond_1

    .line 24
    const-wide/16 v8, 0x1

    and-long v10, v5, v8

    cmp-long v8, v10, v8

    if-nez v8, :cond_0

    .line 25
    ushr-long v8, v5, v1

    const-wide v10, -0x3693a86a2878f0beL    # -5.0564049839430436E45

    xor-long v5, v8, v10

    goto :goto_2

    .line 27
    :cond_0
    ushr-long/2addr v5, v1

    .line 23
    :goto_2
    add-int/lit8 v7, v7, 0x1

    goto :goto_1

    .line 30
    .end local v7    # "k":I
    :cond_1
    sget-object v7, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->table:[[J

    aget-object v7, v7, v3

    aput-wide v5, v7, v0

    .line 21
    .end local v5    # "crc":J
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 34
    .end local v0    # "n":I
    :cond_2
    const/4 v0, 0x0

    .restart local v0    # "n":I
    :goto_3
    if-ge v0, v2, :cond_4

    .line 35
    sget-object v1, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->table:[[J

    aget-object v1, v1, v3

    aget-wide v5, v1, v0

    .line 36
    .restart local v5    # "crc":J
    const/4 v1, 0x1

    .local v1, "k":I
    :goto_4
    if-ge v1, v4, :cond_3

    .line 37
    sget-object v7, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->table:[[J

    aget-object v7, v7, v3

    const-wide/16 v8, 0xff

    and-long/2addr v8, v5

    long-to-int v8, v8

    aget-wide v8, v7, v8

    ushr-long v10, v5, v4

    xor-long v5, v8, v10

    .line 38
    sget-object v7, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->table:[[J

    aget-object v7, v7, v1

    aput-wide v5, v7, v0

    .line 36
    add-int/lit8 v1, v1, 0x1

    goto :goto_4

    .line 34
    .end local v1    # "k":I
    .end local v5    # "crc":J
    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 41
    .end local v0    # "n":I
    :cond_4
    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .line 49
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 50
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->value:J

    .line 51
    return-void
.end method

.method public static combine(JJJ)J
    .locals 19
    .param p0, "crcLast"    # J
    .param p2, "crcNext"    # J
    .param p4, "len2"    # J

    .line 77
    const-wide/16 v0, 0x0

    cmp-long v2, p4, v0

    if-nez v2, :cond_0

    .line 78
    return-wide p0

    .line 82
    :cond_0
    const/16 v2, 0x40

    new-array v3, v2, [J

    .line 83
    .local v3, "even":[J
    new-array v4, v2, [J

    .line 86
    .local v4, "odd":[J
    const/4 v5, 0x0

    const-wide v6, -0x3693a86a2878f0beL    # -5.0564049839430436E45

    aput-wide v6, v4, v5

    .line 88
    const-wide/16 v5, 0x1

    .line 89
    .local v5, "row":J
    const/4 v7, 0x1

    .local v7, "n":I
    :goto_0
    const/4 v8, 0x1

    if-ge v7, v2, :cond_1

    .line 90
    aput-wide v5, v4, v7

    .line 91
    shl-long/2addr v5, v8

    .line 89
    add-int/lit8 v7, v7, 0x1

    goto :goto_0

    .line 95
    :cond_1
    invoke-static {v3, v4}, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->gf2MatrixSquare([J[J)V

    .line 98
    invoke-static {v4, v3}, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->gf2MatrixSquare([J[J)V

    .line 102
    move-wide/from16 v9, p0

    .line 103
    .local v9, "crc1":J
    move-wide/from16 v11, p2

    move-wide v13, v9

    move-wide/from16 v9, p4

    .line 106
    .end local p4    # "len2":J
    .local v9, "len2":J
    .local v11, "crc2":J
    .local v13, "crc1":J
    :cond_2
    invoke-static {v3, v4}, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->gf2MatrixSquare([J[J)V

    .line 107
    const-wide/16 v15, 0x1

    and-long v17, v9, v15

    cmp-long v2, v17, v15

    if-nez v2, :cond_3

    .line 108
    invoke-static {v3, v13, v14}, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->gf2MatrixTimes([JJ)J

    move-result-wide v13

    .line 109
    :cond_3
    ushr-long/2addr v9, v8

    .line 112
    cmp-long v2, v9, v0

    if-nez v2, :cond_4

    .line 113
    goto :goto_1

    .line 116
    :cond_4
    invoke-static {v4, v3}, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->gf2MatrixSquare([J[J)V

    .line 117
    and-long v17, v9, v15

    cmp-long v2, v17, v15

    if-nez v2, :cond_5

    .line 118
    invoke-static {v4, v13, v14}, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->gf2MatrixTimes([JJ)J

    move-result-wide v13

    .line 119
    :cond_5
    ushr-long/2addr v9, v8

    .line 122
    cmp-long v2, v9, v0

    if-nez v2, :cond_2

    .line 125
    :goto_1
    xor-long v0, v13, v11

    .line 126
    .end local v13    # "crc1":J
    .local v0, "crc1":J
    return-wide v0
.end method

.method private static gf2MatrixSquare([J[J)V
    .locals 3
    .param p0, "square"    # [J
    .param p1, "mat"    # [J

    .line 66
    const/4 v0, 0x0

    .local v0, "n":I
    :goto_0
    const/16 v1, 0x40

    if-ge v0, v1, :cond_0

    .line 67
    aget-wide v1, p1, v0

    invoke-static {p1, v1, v2}, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->gf2MatrixTimes([JJ)J

    move-result-wide v1

    aput-wide v1, p0, v0

    .line 66
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 68
    .end local v0    # "n":I
    :cond_0
    return-void
.end method

.method private static gf2MatrixTimes([JJ)J
    .locals 7
    .param p0, "mat"    # [J
    .param p1, "vec"    # J

    .line 54
    const-wide/16 v0, 0x0

    .line 55
    .local v0, "sum":J
    const/4 v2, 0x0

    .line 56
    .local v2, "idx":I
    :goto_0
    const-wide/16 v3, 0x0

    cmp-long v3, p1, v3

    if-eqz v3, :cond_1

    .line 57
    const-wide/16 v3, 0x1

    and-long v5, p1, v3

    cmp-long v3, v5, v3

    if-nez v3, :cond_0

    .line 58
    aget-wide v3, p0, v2

    xor-long/2addr v0, v3

    .line 59
    :cond_0
    const/4 v3, 0x1

    ushr-long/2addr p1, v3

    .line 60
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 62
    :cond_1
    return-wide v0
.end method


# virtual methods
.method public getValue()J
    .locals 2

    .line 133
    iget-wide v0, p0, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->value:J

    return-wide v0
.end method

.method public reset()V
    .locals 2

    .line 138
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->value:J

    .line 139
    return-void
.end method

.method public update(I)V
    .locals 3
    .param p1, "val"    # I

    .line 143
    const/4 v0, 0x1

    new-array v0, v0, [B

    .line 144
    .local v0, "b":[B
    and-int/lit16 v1, p1, 0xff

    int-to-byte v1, v1

    const/4 v2, 0x0

    aput-byte v1, v0, v2

    .line 145
    array-length v1, v0

    invoke-virtual {p0, v0, v1}, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->update([BI)V

    .line 146
    return-void
.end method

.method public update([BI)V
    .locals 1
    .param p1, "b"    # [B
    .param p2, "len"    # I

    .line 152
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0, p2}, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->update([BII)V

    .line 153
    return-void
.end method

.method public update([BII)V
    .locals 12
    .param p1, "b"    # [B
    .param p2, "off"    # I
    .param p3, "len"    # I

    .line 158
    iget-wide v0, p0, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->value:J

    not-long v0, v0

    iput-wide v0, p0, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->value:J

    .line 162
    move v0, p2

    .line 163
    .local v0, "idx":I
    :goto_0
    const/4 v1, 0x0

    const/16 v2, 0x8

    const-wide/16 v3, 0xff

    if-lt p3, v2, :cond_0

    .line 164
    sget-object v5, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->table:[[J

    const/4 v6, 0x7

    aget-object v5, v5, v6

    iget-wide v6, p0, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->value:J

    and-long/2addr v6, v3

    aget-byte v8, p1, v0

    and-int/lit16 v8, v8, 0xff

    int-to-long v8, v8

    xor-long/2addr v6, v8

    long-to-int v6, v6

    aget-wide v6, v5, v6

    sget-object v5, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->table:[[J

    const/4 v8, 0x6

    aget-object v5, v5, v8

    iget-wide v8, p0, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->value:J

    ushr-long/2addr v8, v2

    and-long/2addr v8, v3

    add-int/lit8 v2, v0, 0x1

    aget-byte v2, p1, v2

    and-int/lit16 v2, v2, 0xff

    int-to-long v10, v2

    xor-long/2addr v8, v10

    long-to-int v2, v8

    aget-wide v8, v5, v2

    xor-long v5, v6, v8

    sget-object v2, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->table:[[J

    const/4 v7, 0x5

    aget-object v2, v2, v7

    iget-wide v7, p0, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->value:J

    const/16 v9, 0x10

    ushr-long/2addr v7, v9

    and-long/2addr v7, v3

    add-int/lit8 v9, v0, 0x2

    aget-byte v9, p1, v9

    and-int/lit16 v9, v9, 0xff

    int-to-long v9, v9

    xor-long/2addr v7, v9

    long-to-int v7, v7

    aget-wide v7, v2, v7

    xor-long/2addr v5, v7

    sget-object v2, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->table:[[J

    const/4 v7, 0x4

    aget-object v2, v2, v7

    iget-wide v7, p0, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->value:J

    const/16 v9, 0x18

    ushr-long/2addr v7, v9

    and-long/2addr v7, v3

    add-int/lit8 v9, v0, 0x3

    aget-byte v9, p1, v9

    and-int/lit16 v9, v9, 0xff

    int-to-long v9, v9

    xor-long/2addr v7, v9

    long-to-int v7, v7

    aget-wide v7, v2, v7

    xor-long/2addr v5, v7

    sget-object v2, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->table:[[J

    const/4 v7, 0x3

    aget-object v2, v2, v7

    iget-wide v7, p0, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->value:J

    const/16 v9, 0x20

    ushr-long/2addr v7, v9

    and-long/2addr v7, v3

    add-int/lit8 v9, v0, 0x4

    aget-byte v9, p1, v9

    and-int/lit16 v9, v9, 0xff

    int-to-long v9, v9

    xor-long/2addr v7, v9

    long-to-int v7, v7

    aget-wide v7, v2, v7

    xor-long/2addr v5, v7

    sget-object v2, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->table:[[J

    const/4 v7, 0x2

    aget-object v2, v2, v7

    iget-wide v7, p0, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->value:J

    const/16 v9, 0x28

    ushr-long/2addr v7, v9

    and-long/2addr v7, v3

    add-int/lit8 v9, v0, 0x5

    aget-byte v9, p1, v9

    and-int/lit16 v9, v9, 0xff

    int-to-long v9, v9

    xor-long/2addr v7, v9

    long-to-int v7, v7

    aget-wide v7, v2, v7

    xor-long/2addr v5, v7

    sget-object v2, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->table:[[J

    const/4 v7, 0x1

    aget-object v2, v2, v7

    iget-wide v7, p0, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->value:J

    const/16 v9, 0x30

    ushr-long/2addr v7, v9

    and-long/2addr v3, v7

    add-int/lit8 v7, v0, 0x6

    aget-byte v7, p1, v7

    and-int/lit16 v7, v7, 0xff

    int-to-long v7, v7

    xor-long/2addr v3, v7

    long-to-int v3, v3

    aget-wide v3, v2, v3

    xor-long v2, v5, v3

    sget-object v4, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->table:[[J

    aget-object v1, v4, v1

    iget-wide v4, p0, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->value:J

    const/16 v6, 0x38

    ushr-long/2addr v4, v6

    add-int/lit8 v6, v0, 0x7

    aget-byte v6, p1, v6

    and-int/lit16 v6, v6, 0xff

    int-to-long v6, v6

    xor-long/2addr v4, v6

    long-to-int v4, v4

    aget-wide v4, v1, v4

    xor-long v1, v2, v4

    iput-wide v1, p0, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->value:J

    .line 172
    add-int/lit8 v0, v0, 0x8

    .line 173
    add-int/lit8 p3, p3, -0x8

    goto/16 :goto_0

    .line 177
    :cond_0
    :goto_1
    if-lez p3, :cond_1

    .line 178
    sget-object v5, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->table:[[J

    aget-object v5, v5, v1

    iget-wide v6, p0, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->value:J

    aget-byte v8, p1, v0

    int-to-long v8, v8

    xor-long/2addr v6, v8

    and-long/2addr v6, v3

    long-to-int v6, v6

    aget-wide v6, v5, v6

    iget-wide v8, p0, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->value:J

    ushr-long/2addr v8, v2

    xor-long v5, v6, v8

    iput-wide v5, p0, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->value:J

    .line 179
    add-int/lit8 v0, v0, 0x1

    .line 180
    add-int/lit8 p3, p3, -0x1

    goto :goto_1

    .line 183
    :cond_1
    iget-wide v1, p0, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->value:J

    not-long v1, v1

    iput-wide v1, p0, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;->value:J

    .line 184
    return-void
.end method
