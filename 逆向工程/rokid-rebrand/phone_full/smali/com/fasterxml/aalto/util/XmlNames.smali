.class public final Lcom/fasterxml/aalto/util/XmlNames;
.super Ljava/lang/Object;
.source "XmlNames.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static findIllegalNameChar(Ljava/lang/String;Z)I
    .locals 6
    .param p0, "name"    # Ljava/lang/String;
    .param p1, "xml11"    # Z

    .line 18
    const/4 v0, 0x0

    .line 19
    .local v0, "ptr":I
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v1

    .line 20
    .local v1, "c":C
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    .line 21
    .local v2, "len":I
    const v3, 0xe000

    const v4, 0xd800

    if-lt v1, v4, :cond_2

    if-lt v1, v3, :cond_0

    goto :goto_0

    .line 32
    :cond_0
    const/4 v5, 0x2

    if-ge v2, v5, :cond_1

    .line 33
    return v0

    .line 35
    :cond_1
    add-int/lit8 v0, v0, 0x1

    .line 37
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v5

    invoke-static {v1, v5}, Lcom/fasterxml/aalto/util/XmlNames;->validSurrogateNameChar(CC)Z

    move-result v5

    if-nez v5, :cond_4

    .line 38
    return v0

    .line 22
    :cond_2
    :goto_0
    if-eqz p1, :cond_3

    .line 23
    invoke-static {v1}, Lcom/fasterxml/aalto/util/XmlChars;->is11NameStartChar(I)Z

    move-result v5

    if-nez v5, :cond_4

    .line 24
    return v0

    .line 27
    :cond_3
    invoke-static {v1}, Lcom/fasterxml/aalto/util/XmlChars;->is10NameStartChar(I)Z

    move-result v5

    if-nez v5, :cond_4

    .line 28
    return v0

    .line 41
    :cond_4
    add-int/lit8 v0, v0, 0x1

    .line 43
    if-eqz p1, :cond_a

    .line 44
    :goto_1
    if-ge v0, v2, :cond_10

    .line 45
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v1

    .line 46
    if-lt v1, v4, :cond_8

    if-lt v1, v3, :cond_5

    goto :goto_2

    .line 51
    :cond_5
    add-int/lit8 v5, v0, 0x1

    if-lt v5, v2, :cond_6

    .line 52
    return v0

    .line 54
    :cond_6
    add-int/lit8 v5, v0, 0x1

    invoke-virtual {p0, v5}, Ljava/lang/String;->charAt(I)C

    move-result v5

    invoke-static {v1, v5}, Lcom/fasterxml/aalto/util/XmlNames;->validSurrogateNameChar(CC)Z

    move-result v5

    if-nez v5, :cond_7

    .line 55
    return v0

    .line 57
    :cond_7
    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 47
    :cond_8
    :goto_2
    invoke-static {v1}, Lcom/fasterxml/aalto/util/XmlChars;->is11NameChar(I)Z

    move-result v5

    if-nez v5, :cond_9

    .line 48
    return v0

    .line 44
    :cond_9
    :goto_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 61
    :cond_a
    :goto_4
    if-ge v0, v2, :cond_10

    .line 62
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v1

    .line 63
    if-lt v1, v4, :cond_e

    if-lt v1, v3, :cond_b

    goto :goto_5

    .line 68
    :cond_b
    add-int/lit8 v5, v0, 0x1

    if-lt v5, v2, :cond_c

    .line 69
    return v0

    .line 71
    :cond_c
    add-int/lit8 v5, v0, 0x1

    invoke-virtual {p0, v5}, Ljava/lang/String;->charAt(I)C

    move-result v5

    invoke-static {v1, v5}, Lcom/fasterxml/aalto/util/XmlNames;->validSurrogateNameChar(CC)Z

    move-result v5

    if-nez v5, :cond_d

    .line 72
    return v0

    .line 74
    :cond_d
    add-int/lit8 v0, v0, 0x1

    goto :goto_6

    .line 64
    :cond_e
    :goto_5
    invoke-static {v1}, Lcom/fasterxml/aalto/util/XmlChars;->is10NameChar(I)Z

    move-result v5

    if-nez v5, :cond_f

    .line 65
    return v0

    .line 61
    :cond_f
    :goto_6
    add-int/lit8 v0, v0, 0x1

    goto :goto_4

    .line 78
    :cond_10
    const/4 v3, -0x1

    return v3
.end method

.method private static validSurrogateNameChar(CC)Z
    .locals 1
    .param p0, "firstChar"    # C
    .param p1, "sec"    # C

    .line 83
    nop

    .line 84
    const/4 v0, 0x0

    return v0
.end method
