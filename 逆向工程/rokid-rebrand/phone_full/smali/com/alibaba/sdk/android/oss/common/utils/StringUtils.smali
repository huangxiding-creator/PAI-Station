.class public Lcom/alibaba/sdk/android/oss/common/utils/StringUtils;
.super Ljava/lang/Object;
.source "StringUtils.java"


# static fields
.field public static final UTF8:Ljava/nio/charset/Charset;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 10
    const-string/jumbo v0, "utf-8"

    invoke-static {v0}, Ljava/nio/charset/Charset;->forName(Ljava/lang/String;)Ljava/nio/charset/Charset;

    move-result-object v0

    sput-object v0, Lcom/alibaba/sdk/android/oss/common/utils/StringUtils;->UTF8:Ljava/nio/charset/Charset;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static isNullOrEmpty(Ljava/lang/String;)Z
    .locals 1
    .param p0, "value"    # Ljava/lang/String;

    .line 16
    if-eqz p0, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    :goto_1
    return v0
.end method

.method public static join(Ljava/lang/String;Ljava/util/Collection;)Ljava/lang/String;
    .locals 5
    .param p0, "joiner"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Collection<",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/lang/String;"
        }
    .end annotation

    .line 52
    .local p1, "collection":Ljava/util/Collection;, "Ljava/util/Collection<Ljava/lang/String;>;"
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 53
    .local v0, "builder":Ljava/lang/StringBuilder;
    const/4 v1, 0x0

    .line 55
    .local v1, "i":I
    invoke-interface {p1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .line 56
    .local v3, "part":Ljava/lang/String;
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 57
    invoke-interface {p1}, Ljava/util/Collection;->size()I

    move-result v4

    add-int/lit8 v4, v4, -0x1

    if-ge v1, v4, :cond_0

    .line 58
    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 60
    :cond_0
    nop

    .end local v3    # "part":Ljava/lang/String;
    add-int/lit8 v1, v1, 0x1

    .line 61
    goto :goto_0

    .line 62
    :cond_1
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    return-object v2
.end method

.method public static varargs join(Ljava/lang/String;[Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p0, "joiner"    # Ljava/lang/String;
    .param p1, "parts"    # [Ljava/lang/String;

    .line 36
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 37
    .local v0, "builder":Ljava/lang/StringBuilder;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p1

    if-ge v1, v2, :cond_1

    .line 38
    aget-object v2, p1, v1

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 39
    array-length v2, p1

    add-int/lit8 v2, v2, -0x1

    if-ge v1, v2, :cond_0

    .line 40
    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 37
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 43
    .end local v1    # "i":I
    :cond_1
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public static replaceEach(Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/String;)Ljava/lang/String;
    .locals 13
    .param p0, "text"    # Ljava/lang/String;
    .param p1, "searchList"    # [Ljava/lang/String;
    .param p2, "replacementList"    # [Ljava/lang/String;

    .line 66
    array-length v0, p1

    .line 67
    .local v0, "searchLength":I
    array-length v1, p2

    .line 69
    .local v1, "replacementLength":I
    invoke-static {p0}, Lcom/alibaba/sdk/android/oss/common/utils/StringUtils;->isNullOrEmpty(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_13

    if-nez v0, :cond_0

    if-nez v1, :cond_0

    goto/16 :goto_9

    .line 74
    :cond_0
    if-ne v0, v1, :cond_12

    .line 82
    new-array v2, v0, [Z

    .line 85
    .local v2, "noMoreMatchesForReplIndex":[Z
    const/4 v3, -0x1

    .line 86
    .local v3, "textIndex":I
    const/4 v4, -0x1

    .line 87
    .local v4, "replaceIndex":I
    const/4 v5, -0x1

    .line 91
    .local v5, "tempIndex":I
    const/4 v6, 0x0

    .local v6, "i":I
    :goto_0
    const/4 v7, -0x1

    const/4 v8, 0x1

    if-ge v6, v0, :cond_5

    .line 92
    aget-boolean v9, v2, v6

    if-nez v9, :cond_4

    aget-object v9, p1, v6

    invoke-static {v9}, Lcom/alibaba/sdk/android/oss/common/utils/StringUtils;->isNullOrEmpty(Ljava/lang/String;)Z

    move-result v9

    if-nez v9, :cond_4

    aget-object v9, p2, v6

    if-nez v9, :cond_1

    .line 93
    goto :goto_1

    .line 95
    :cond_1
    aget-object v9, p1, v6

    invoke-virtual {p0, v9}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v5

    .line 98
    if-ne v5, v7, :cond_2

    .line 99
    aput-boolean v8, v2, v6

    goto :goto_1

    .line 101
    :cond_2
    if-eq v3, v7, :cond_3

    if-ge v5, v3, :cond_4

    .line 102
    :cond_3
    move v3, v5

    .line 103
    move v4, v6

    .line 91
    :cond_4
    :goto_1
    add-int/lit8 v6, v6, 0x1

    goto :goto_0

    .line 110
    .end local v6    # "i":I
    :cond_5
    if-ne v3, v7, :cond_6

    .line 111
    return-object p0

    .line 114
    :cond_6
    const/4 v6, 0x0

    .line 117
    .local v6, "start":I
    const/4 v9, 0x0

    .line 120
    .local v9, "increase":I
    const/4 v10, 0x0

    .local v10, "i":I
    :goto_2
    array-length v11, p1

    if-ge v10, v11, :cond_9

    .line 121
    aget-object v11, p1, v10

    if-eqz v11, :cond_8

    aget-object v11, p2, v10

    if-nez v11, :cond_7

    .line 122
    goto :goto_3

    .line 124
    :cond_7
    aget-object v11, p2, v10

    invoke-virtual {v11}, Ljava/lang/String;->length()I

    move-result v11

    aget-object v12, p1, v10

    invoke-virtual {v12}, Ljava/lang/String;->length()I

    move-result v12

    sub-int/2addr v11, v12

    .line 125
    .local v11, "greater":I
    if-lez v11, :cond_8

    .line 126
    mul-int/lit8 v12, v11, 0x3

    add-int/2addr v9, v12

    .line 120
    .end local v11    # "greater":I
    :cond_8
    :goto_3
    add-int/lit8 v10, v10, 0x1

    goto :goto_2

    .line 130
    .end local v10    # "i":I
    :cond_9
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v10

    div-int/lit8 v10, v10, 0x5

    invoke-static {v9, v10}, Ljava/lang/Math;->min(II)I

    move-result v9

    .line 132
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v11

    add-int/2addr v11, v9

    invoke-direct {v10, v11}, Ljava/lang/StringBuilder;-><init>(I)V

    .line 134
    .local v10, "buf":Ljava/lang/StringBuilder;
    :goto_4
    if-eq v3, v7, :cond_10

    .line 136
    move v11, v6

    .local v11, "i":I
    :goto_5
    if-ge v11, v3, :cond_a

    .line 137
    invoke-virtual {p0, v11}, Ljava/lang/String;->charAt(I)C

    move-result v12

    invoke-virtual {v10, v12}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 136
    add-int/lit8 v11, v11, 0x1

    goto :goto_5

    .line 139
    .end local v11    # "i":I
    :cond_a
    aget-object v11, p2, v4

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 141
    aget-object v11, p1, v4

    invoke-virtual {v11}, Ljava/lang/String;->length()I

    move-result v11

    add-int v6, v3, v11

    .line 143
    const/4 v3, -0x1

    .line 144
    const/4 v4, -0x1

    .line 145
    const/4 v5, -0x1

    .line 148
    const/4 v11, 0x0

    .restart local v11    # "i":I
    :goto_6
    if-ge v11, v0, :cond_f

    .line 149
    aget-boolean v12, v2, v11

    if-nez v12, :cond_e

    aget-object v12, p1, v11

    if-eqz v12, :cond_e

    aget-object v12, p1, v11

    .line 150
    invoke-virtual {v12}, Ljava/lang/String;->isEmpty()Z

    move-result v12

    if-nez v12, :cond_e

    aget-object v12, p2, v11

    if-nez v12, :cond_b

    .line 151
    goto :goto_7

    .line 153
    :cond_b
    aget-object v12, p1, v11

    invoke-virtual {p0, v12, v6}, Ljava/lang/String;->indexOf(Ljava/lang/String;I)I

    move-result v5

    .line 156
    if-ne v5, v7, :cond_c

    .line 157
    aput-boolean v8, v2, v11

    goto :goto_7

    .line 159
    :cond_c
    if-eq v3, v7, :cond_d

    if-ge v5, v3, :cond_e

    .line 160
    :cond_d
    move v3, v5

    .line 161
    move v4, v11

    .line 148
    :cond_e
    :goto_7
    add-int/lit8 v11, v11, 0x1

    goto :goto_6

    .end local v11    # "i":I
    :cond_f
    goto :goto_4

    .line 169
    :cond_10
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v7

    .line 170
    .local v7, "textLength":I
    move v8, v6

    .local v8, "i":I
    :goto_8
    if-ge v8, v7, :cond_11

    .line 171
    invoke-virtual {p0, v8}, Ljava/lang/String;->charAt(I)C

    move-result v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 170
    add-int/lit8 v8, v8, 0x1

    goto :goto_8

    .line 173
    .end local v8    # "i":I
    :cond_11
    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    return-object v8

    .line 75
    .end local v2    # "noMoreMatchesForReplIndex":[Z
    .end local v3    # "textIndex":I
    .end local v4    # "replaceIndex":I
    .end local v5    # "tempIndex":I
    .end local v6    # "start":I
    .end local v7    # "textLength":I
    .end local v9    # "increase":I
    .end local v10    # "buf":Ljava/lang/StringBuilder;
    :cond_12
    new-instance v2, Ljava/lang/IllegalArgumentException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Search and Replace array lengths don\'t match: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " vs "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 70
    :cond_13
    :goto_9
    return-object p0
.end method

.method public static trim(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p0, "value"    # Ljava/lang/String;

    .line 24
    if-nez p0, :cond_0

    .line 25
    const/4 v0, 0x0

    return-object v0

    .line 27
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
