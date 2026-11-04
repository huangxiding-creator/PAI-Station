.class public final Lcom/fasterxml/aalto/util/TextUtil;
.super Ljava/lang/Object;
.source "TextUtil.java"


# static fields
.field static final CHAR_SPACE:I = 0x20


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static isAllWhitespace(Ljava/lang/String;Z)Z
    .locals 4
    .param p0, "str"    # Ljava/lang/String;
    .param p1, "xml11"    # Z

    .line 11
    const/4 v0, 0x0

    .local v0, "i":I
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    .local v1, "len":I
    :goto_0
    if-ge v0, v1, :cond_2

    .line 12
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v2

    .line 13
    .local v2, "c":I
    const/16 v3, 0x20

    if-le v2, v3, :cond_1

    if-eqz p1, :cond_0

    const/16 v3, 0x85

    if-eq v2, v3, :cond_1

    .line 14
    :cond_0
    const/4 v3, 0x0

    return v3

    .line 11
    .end local v2    # "c":I
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 17
    .end local v0    # "i":I
    .end local v1    # "len":I
    :cond_2
    const/4 v0, 0x1

    return v0
.end method

.method public static isAllWhitespace([CIIZ)Z
    .locals 2
    .param p0, "ch"    # [C
    .param p1, "start"    # I
    .param p2, "len"    # I
    .param p3, "xml11"    # Z

    .line 23
    add-int/2addr p2, p1

    .line 24
    :goto_0
    if-ge p1, p2, :cond_2

    .line 25
    aget-char v0, p0, p1

    .line 26
    .local v0, "c":I
    const/16 v1, 0x20

    if-le v0, v1, :cond_1

    if-eqz p3, :cond_0

    const/16 v1, 0x85

    if-eq v0, v1, :cond_1

    .line 27
    :cond_0
    const/4 v1, 0x0

    return v1

    .line 24
    .end local v0    # "c":I
    :cond_1
    add-int/lit8 p1, p1, 0x1

    goto :goto_0

    .line 30
    :cond_2
    const/4 v0, 0x1

    return v0
.end method
