.class public final Lorg/apache/commons/compress/harmony/unpack200/SegmentUtils;
.super Ljava/lang/Object;
.source "SegmentUtils.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 22
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static countArgs(Ljava/lang/String;)I
    .locals 1
    .param p0, "descriptor"    # Ljava/lang/String;

    .line 25
    const/4 v0, 0x1

    invoke-static {p0, v0}, Lorg/apache/commons/compress/harmony/unpack200/SegmentUtils;->countArgs(Ljava/lang/String;I)I

    move-result v0

    return v0
.end method

.method protected static countArgs(Ljava/lang/String;I)I
    .locals 8
    .param p0, "descriptor"    # Ljava/lang/String;
    .param p1, "widthOfLongsAndDoubles"    # I

    .line 42
    const/16 v0, 0x28

    invoke-virtual {p0, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    .line 43
    .local v0, "bra":I
    const/16 v1, 0x29

    invoke-virtual {p0, v1}, Ljava/lang/String;->indexOf(I)I

    move-result v1

    .line 44
    .local v1, "ket":I
    const/4 v2, -0x1

    if-eq v0, v2, :cond_8

    if-eq v1, v2, :cond_8

    if-lt v1, v0, :cond_8

    .line 48
    const/4 v2, 0x0

    .line 49
    .local v2, "inType":Z
    const/4 v3, 0x0

    .line 50
    .local v3, "consumingNextType":Z
    const/4 v4, 0x0

    .line 51
    .local v4, "count":I
    add-int/lit8 v5, v0, 0x1

    .local v5, "i":I
    :goto_0
    if-ge v5, v1, :cond_7

    .line 52
    invoke-virtual {p0, v5}, Ljava/lang/String;->charAt(I)C

    move-result v6

    .line 53
    .local v6, "charAt":C
    if-eqz v2, :cond_0

    const/16 v7, 0x3b

    if-ne v6, v7, :cond_0

    .line 54
    const/4 v2, 0x0

    .line 55
    const/4 v3, 0x0

    goto :goto_2

    .line 56
    :cond_0
    if-nez v2, :cond_1

    const/16 v7, 0x4c

    if-ne v6, v7, :cond_1

    .line 57
    const/4 v2, 0x1

    .line 58
    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    .line 59
    :cond_1
    const/16 v7, 0x5b

    if-ne v6, v7, :cond_2

    .line 60
    const/4 v3, 0x1

    goto :goto_2

    .line 61
    :cond_2
    if-eqz v2, :cond_3

    goto :goto_2

    .line 63
    :cond_3
    if-eqz v3, :cond_4

    .line 64
    add-int/lit8 v4, v4, 0x1

    .line 65
    const/4 v3, 0x0

    goto :goto_2

    .line 66
    :cond_4
    const/16 v7, 0x44

    if-eq v6, v7, :cond_6

    const/16 v7, 0x4a

    if-ne v6, v7, :cond_5

    goto :goto_1

    .line 69
    :cond_5
    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    .line 67
    :cond_6
    :goto_1
    add-int/2addr v4, p1

    .line 51
    .end local v6    # "charAt":C
    :goto_2
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    .line 72
    .end local v5    # "i":I
    :cond_7
    return v4

    .line 45
    .end local v2    # "inType":Z
    .end local v3    # "consumingNextType":Z
    .end local v4    # "count":I
    :cond_8
    new-instance v2, Ljava/lang/IllegalArgumentException;

    const-string v3, "No arguments"

    invoke-direct {v2, v3}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v2
.end method

.method public static countBit16([I)I
    .locals 4
    .param p0, "flags"    # [I

    .line 86
    const/4 v0, 0x0

    .line 87
    .local v0, "count":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_1

    .line 88
    aget v2, p0, v1

    const/high16 v3, 0x10000

    and-int/2addr v2, v3

    if-eqz v2, :cond_0

    .line 89
    add-int/lit8 v0, v0, 0x1

    .line 87
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 92
    .end local v1    # "i":I
    :cond_1
    return v0
.end method

.method public static countBit16([J)I
    .locals 6
    .param p0, "flags"    # [J

    .line 96
    const/4 v0, 0x0

    .line 97
    .local v0, "count":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_1

    .line 98
    aget-wide v2, p0, v1

    const-wide/32 v4, 0x10000

    and-long/2addr v2, v4

    const-wide/16 v4, 0x0

    cmp-long v2, v2, v4

    if-eqz v2, :cond_0

    .line 99
    add-int/lit8 v0, v0, 0x1

    .line 97
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 102
    .end local v1    # "i":I
    :cond_1
    return v0
.end method

.method public static countBit16([[J)I
    .locals 8
    .param p0, "flags"    # [[J

    .line 106
    const/4 v0, 0x0

    .line 107
    .local v0, "count":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_2

    .line 108
    const/4 v2, 0x0

    .local v2, "j":I
    :goto_1
    aget-object v3, p0, v1

    array-length v3, v3

    if-ge v2, v3, :cond_1

    .line 109
    aget-object v3, p0, v1

    aget-wide v4, v3, v2

    const-wide/32 v6, 0x10000

    and-long v3, v4, v6

    const-wide/16 v5, 0x0

    cmp-long v3, v3, v5

    if-eqz v3, :cond_0

    .line 110
    add-int/lit8 v0, v0, 0x1

    .line 108
    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 107
    .end local v2    # "j":I
    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 114
    .end local v1    # "i":I
    :cond_2
    return v0
.end method

.method public static countInvokeInterfaceArgs(Ljava/lang/String;)I
    .locals 1
    .param p0, "descriptor"    # Ljava/lang/String;

    .line 29
    const/4 v0, 0x2

    invoke-static {p0, v0}, Lorg/apache/commons/compress/harmony/unpack200/SegmentUtils;->countArgs(Ljava/lang/String;I)I

    move-result v0

    return v0
.end method

.method public static countMatches([JLorg/apache/commons/compress/harmony/unpack200/IMatcher;)I
    .locals 4
    .param p0, "flags"    # [J
    .param p1, "matcher"    # Lorg/apache/commons/compress/harmony/unpack200/IMatcher;

    .line 76
    const/4 v0, 0x0

    .line 77
    .local v0, "count":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_1

    .line 78
    aget-wide v2, p0, v1

    invoke-interface {p1, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/IMatcher;->matches(J)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 79
    add-int/lit8 v0, v0, 0x1

    .line 77
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 82
    .end local v1    # "i":I
    :cond_1
    return v0
.end method

.method public static countMatches([[JLorg/apache/commons/compress/harmony/unpack200/IMatcher;)I
    .locals 3
    .param p0, "flags"    # [[J
    .param p1, "matcher"    # Lorg/apache/commons/compress/harmony/unpack200/IMatcher;

    .line 118
    const/4 v0, 0x0

    .line 119
    .local v0, "count":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p0

    if-ge v1, v2, :cond_0

    .line 120
    aget-object v2, p0, v1

    invoke-static {v2, p1}, Lorg/apache/commons/compress/harmony/unpack200/SegmentUtils;->countMatches([JLorg/apache/commons/compress/harmony/unpack200/IMatcher;)I

    move-result v2

    add-int/2addr v0, v2

    .line 119
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 122
    .end local v1    # "i":I
    :cond_0
    return v0
.end method
