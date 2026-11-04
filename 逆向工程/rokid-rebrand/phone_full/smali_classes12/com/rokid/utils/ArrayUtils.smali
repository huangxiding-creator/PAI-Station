.class public Lcom/rokid/utils/ArrayUtils;
.super Ljava/lang/Object;
.source "ArrayUtils.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static append([Ljava/lang/String;Ljava/lang/String;)[Ljava/lang/String;
    .locals 4
    .param p0, "src"    # [Ljava/lang/String;
    .param p1, "newStr"    # Ljava/lang/String;

    .line 37
    invoke-static {p0, p1}, Lcom/rokid/utils/ArrayUtils;->contains([Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 38
    return-object p0

    .line 41
    :cond_0
    const/4 v0, 0x0

    if-eqz p0, :cond_1

    array-length v1, p0

    goto :goto_0

    :cond_1
    move v1, v0

    :goto_0
    add-int/lit8 v1, v1, 0x1

    .line 42
    .local v1, "newLength":I
    new-array v2, v1, [Ljava/lang/String;

    .line 43
    .local v2, "newArray":[Ljava/lang/String;
    if-eqz p0, :cond_2

    .line 44
    array-length v3, p0

    invoke-static {p0, v0, v2, v0, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 46
    :cond_2
    add-int/lit8 v0, v1, -0x1

    aput-object p1, v2, v0

    .line 47
    return-object v2
.end method

.method public static combineArray(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 5
    .param p0, "firstArray"    # Ljava/lang/Object;
    .param p1, "secondArray"    # Ljava/lang/Object;

    .line 64
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getComponentType()Ljava/lang/Class;

    move-result-object v0

    .line 65
    .local v0, "localClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    invoke-static {p0}, Ljava/lang/reflect/Array;->getLength(Ljava/lang/Object;)I

    move-result v1

    .line 66
    .local v1, "firstArrayLength":I
    invoke-static {p1}, Ljava/lang/reflect/Array;->getLength(Ljava/lang/Object;)I

    move-result v2

    .line 67
    .local v2, "secondArrayLength":I
    add-int v3, v1, v2

    invoke-static {v0, v3}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;I)Ljava/lang/Object;

    move-result-object v3

    .line 68
    .local v3, "result":Ljava/lang/Object;
    const/4 v4, 0x0

    invoke-static {p0, v4, v3, v4, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 69
    invoke-static {p1, v4, v3, v1, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 70
    return-object v3
.end method

.method private static contains([Ljava/lang/String;Ljava/lang/String;)Z
    .locals 5
    .param p0, "array"    # [Ljava/lang/String;
    .param p1, "value"    # Ljava/lang/String;

    .line 51
    const/4 v0, 0x0

    if-nez p0, :cond_0

    .line 52
    return v0

    .line 55
    :cond_0
    array-length v1, p0

    move v2, v0

    :goto_0
    if-ge v2, v1, :cond_2

    aget-object v3, p0, v2

    .line 56
    .local v3, "str":Ljava/lang/String;
    invoke-static {v3, p1}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 57
    const/4 v0, 0x1

    return v0

    .line 55
    .end local v3    # "str":Ljava/lang/String;
    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 60
    :cond_2
    return v0
.end method

.method public static copy(Ljava/lang/Object;ILjava/lang/Object;II)V
    .locals 0
    .param p0, "src"    # Ljava/lang/Object;
    .param p1, "srcPos"    # I
    .param p2, "dest"    # Ljava/lang/Object;
    .param p3, "destPos"    # I
    .param p4, "length"    # I

    .line 27
    invoke-static {p0, p1, p2, p3, p4}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 28
    return-void
.end method

.method public static copy([Ljava/lang/String;I[Ljava/lang/String;II)V
    .locals 0
    .param p0, "src"    # [Ljava/lang/String;
    .param p1, "srcPos"    # I
    .param p2, "dest"    # [Ljava/lang/String;
    .param p3, "destPos"    # I
    .param p4, "length"    # I

    .line 33
    invoke-static {p0, p1, p2, p3, p4}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 34
    return-void
.end method

.method public static isNotNullAndNotEmpty([Ljava/lang/Object;)Z
    .locals 1
    .param p0, "array"    # [Ljava/lang/Object;

    .line 21
    invoke-static {p0}, Lcom/rokid/utils/ArrayUtils;->isNullOrEmpty([Ljava/lang/Object;)Z

    move-result v0

    xor-int/lit8 v0, v0, 0x1

    return v0
.end method

.method public static isNullOrEmpty([Ljava/lang/Object;)Z
    .locals 2
    .param p0, "array"    # [Ljava/lang/Object;

    .line 17
    const/4 v0, 0x1

    if-eqz p0, :cond_1

    array-length v1, p0

    if-ge v1, v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :cond_1
    :goto_0
    return v0
.end method
