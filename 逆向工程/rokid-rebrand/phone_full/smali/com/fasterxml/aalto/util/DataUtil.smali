.class public final Lcom/fasterxml/aalto/util/DataUtil;
.super Ljava/lang/Object;
.source "DataUtil.java"


# static fields
.field static final EMPTY_CHAR_ARRAY:[C


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 7
    const/4 v0, 0x0

    new-array v0, v0, [C

    sput-object v0, Lcom/fasterxml/aalto/util/DataUtil;->EMPTY_CHAR_ARRAY:[C

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getEmptyCharArray()[C
    .locals 1

    .line 12
    sget-object v0, Lcom/fasterxml/aalto/util/DataUtil;->EMPTY_CHAR_ARRAY:[C

    return-object v0
.end method

.method public static growAnyArrayBy(Ljava/lang/Object;I)Ljava/lang/Object;
    .locals 4
    .param p0, "arr"    # Ljava/lang/Object;
    .param p1, "more"    # I

    .line 59
    if-eqz p0, :cond_0

    .line 62
    move-object v0, p0

    .line 63
    .local v0, "old":Ljava/lang/Object;
    invoke-static {p0}, Ljava/lang/reflect/Array;->getLength(Ljava/lang/Object;)I

    move-result v1

    .line 64
    .local v1, "len":I
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->getComponentType()Ljava/lang/Class;

    move-result-object v2

    add-int v3, v1, p1

    invoke-static {v2, v3}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;I)Ljava/lang/Object;

    move-result-object p0

    .line 65
    const/4 v2, 0x0

    invoke-static {v0, v2, p0, v2, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 66
    return-object p0

    .line 60
    .end local v0    # "old":Ljava/lang/Object;
    .end local v1    # "len":I
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Null array"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static growArrayBy([CI)[C
    .locals 3
    .param p0, "arr"    # [C
    .param p1, "more"    # I

    .line 47
    if-nez p0, :cond_0

    .line 48
    new-array v0, p1, [C

    return-object v0

    .line 50
    :cond_0
    move-object v0, p0

    .line 51
    .local v0, "old":[C
    array-length v1, p0

    .line 52
    .local v1, "len":I
    add-int v2, v1, p1

    new-array p0, v2, [C

    .line 53
    const/4 v2, 0x0

    invoke-static {v0, v2, p0, v2, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 54
    return-object p0
.end method

.method public static growArrayBy([II)[I
    .locals 3
    .param p0, "arr"    # [I
    .param p1, "more"    # I

    .line 35
    if-nez p0, :cond_0

    .line 36
    new-array v0, p1, [I

    return-object v0

    .line 38
    :cond_0
    move-object v0, p0

    .line 39
    .local v0, "old":[I
    array-length v1, p0

    .line 40
    .local v1, "len":I
    add-int v2, v1, p1

    new-array p0, v2, [I

    .line 41
    const/4 v2, 0x0

    invoke-static {v0, v2, p0, v2, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 42
    return-object p0
.end method

.method public static growArrayBy([Ljava/lang/String;I)[Ljava/lang/String;
    .locals 3
    .param p0, "arr"    # [Ljava/lang/String;
    .param p1, "more"    # I

    .line 23
    if-nez p0, :cond_0

    .line 24
    new-array v0, p1, [Ljava/lang/String;

    return-object v0

    .line 26
    :cond_0
    move-object v0, p0

    .line 27
    .local v0, "old":[Ljava/lang/String;
    array-length v1, p0

    .line 28
    .local v1, "len":I
    add-int v2, v1, p1

    new-array p0, v2, [Ljava/lang/String;

    .line 29
    const/4 v2, 0x0

    invoke-static {v0, v2, p0, v2, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 30
    return-object p0
.end method
