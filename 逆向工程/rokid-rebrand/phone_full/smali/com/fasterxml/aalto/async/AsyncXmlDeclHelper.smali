.class public Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;
.super Ljava/lang/Object;
.source "AsyncXmlDeclHelper.java"


# static fields
.field private static final NAME_ENCODING:Lcom/fasterxml/aalto/in/PName2;

.field private static final NAME_STANDALONE:Lcom/fasterxml/aalto/in/PName3;

.field private static final NAME_VERSION:Lcom/fasterxml/aalto/in/PName2;

.field private static final NAME_XML:Lcom/fasterxml/aalto/in/PName1;

.field private static final QUAD_ENCODING1:I

.field private static final QUAD_ENCODING2:I

.field private static final QUAD_STANDALONE1:I

.field private static final QUAD_STANDALONE2:I

.field private static final QUAD_STANDALONE3:I

.field private static final QUAD_VERSION1:I

.field private static final QUAD_VERSION2:I

.field private static final QUAD_XML:I


# direct methods
.method static constructor <clinit>()V
    .locals 16

    .line 14
    const-string/jumbo v0, "xml"

    invoke-static {v0}, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->asciiQuads(Ljava/lang/String;)[I

    move-result-object v0

    const/4 v1, 0x0

    aget v0, v0, v1

    sput v0, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->QUAD_XML:I

    .line 18
    const-string/jumbo v0, "version"

    invoke-static {v0}, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->asciiQuads(Ljava/lang/String;)[I

    move-result-object v0

    .line 19
    .local v0, "q":[I
    aget v2, v0, v1

    sput v2, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->QUAD_VERSION1:I

    .line 20
    const/4 v2, 0x1

    aget v3, v0, v2

    sput v3, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->QUAD_VERSION2:I

    .line 25
    .end local v0    # "q":[I
    const-string/jumbo v0, "standalone"

    invoke-static {v0}, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->asciiQuads(Ljava/lang/String;)[I

    move-result-object v0

    .line 26
    .restart local v0    # "q":[I
    aget v3, v0, v1

    sput v3, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->QUAD_STANDALONE1:I

    .line 27
    aget v3, v0, v2

    sput v3, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->QUAD_STANDALONE2:I

    .line 28
    const/4 v3, 0x2

    aget v3, v0, v3

    sput v3, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->QUAD_STANDALONE3:I

    .line 33
    .end local v0    # "q":[I
    const-string v0, "encoding"

    invoke-static {v0}, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->asciiQuads(Ljava/lang/String;)[I

    move-result-object v0

    .line 34
    .restart local v0    # "q":[I
    aget v1, v0, v1

    sput v1, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->QUAD_ENCODING1:I

    .line 35
    aget v1, v0, v2

    sput v1, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->QUAD_ENCODING2:I

    .line 40
    .end local v0    # "q":[I
    new-instance v0, Lcom/fasterxml/aalto/in/PName1;

    const/4 v6, 0x0

    sget v7, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->QUAD_XML:I

    const-string/jumbo v3, "xml"

    const/4 v4, 0x0

    const-string/jumbo v5, "xml"

    move-object v2, v0

    invoke-direct/range {v2 .. v7}, Lcom/fasterxml/aalto/in/PName1;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;II)V

    sput-object v0, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->NAME_XML:Lcom/fasterxml/aalto/in/PName1;

    .line 41
    new-instance v0, Lcom/fasterxml/aalto/in/PName2;

    sget v13, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->QUAD_VERSION1:I

    sget v14, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->QUAD_VERSION2:I

    const-string/jumbo v9, "version"

    const/4 v10, 0x0

    const-string/jumbo v11, "version"

    const/4 v12, 0x0

    move-object v8, v0

    invoke-direct/range {v8 .. v14}, Lcom/fasterxml/aalto/in/PName2;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;III)V

    sput-object v0, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->NAME_VERSION:Lcom/fasterxml/aalto/in/PName2;

    .line 43
    new-instance v0, Lcom/fasterxml/aalto/in/PName3;

    sget v6, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->QUAD_STANDALONE1:I

    sget v7, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->QUAD_STANDALONE2:I

    sget v8, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->QUAD_STANDALONE3:I

    const-string/jumbo v2, "standalone"

    const/4 v3, 0x0

    const-string/jumbo v4, "standalone"

    const/4 v5, 0x0

    move-object v1, v0

    invoke-direct/range {v1 .. v8}, Lcom/fasterxml/aalto/in/PName3;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IIII)V

    sput-object v0, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->NAME_STANDALONE:Lcom/fasterxml/aalto/in/PName3;

    .line 45
    new-instance v0, Lcom/fasterxml/aalto/in/PName2;

    sget v14, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->QUAD_ENCODING1:I

    sget v15, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->QUAD_ENCODING2:I

    const-string v10, "encoding"

    const/4 v11, 0x0

    const-string v12, "encoding"

    const/4 v13, 0x0

    move-object v9, v0

    invoke-direct/range {v9 .. v15}, Lcom/fasterxml/aalto/in/PName2;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;III)V

    sput-object v0, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->NAME_ENCODING:Lcom/fasterxml/aalto/in/PName2;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 12
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static asciiQuads(Ljava/lang/String;)[I
    .locals 6
    .param p0, "word"    # Ljava/lang/String;

    .line 85
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    .line 86
    .local v0, "blen":I
    add-int/lit8 v1, v0, 0x3

    div-int/lit8 v1, v1, 0x4

    new-array v1, v1, [I

    .line 87
    .local v1, "result":[I
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    if-ge v2, v0, :cond_1

    .line 88
    invoke-virtual {p0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v3

    .line 90
    .local v3, "x":I
    add-int/lit8 v2, v2, 0x1

    if-ge v2, v0, :cond_0

    .line 91
    shl-int/lit8 v4, v3, 0x8

    invoke-virtual {p0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v5

    or-int v3, v4, v5

    .line 92
    add-int/lit8 v2, v2, 0x1

    if-ge v2, v0, :cond_0

    .line 93
    shl-int/lit8 v4, v3, 0x8

    invoke-virtual {p0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v5

    or-int v3, v4, v5

    .line 94
    add-int/lit8 v2, v2, 0x1

    if-ge v2, v0, :cond_0

    .line 95
    shl-int/lit8 v4, v3, 0x8

    invoke-virtual {p0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v5

    or-int v3, v4, v5

    .line 99
    :cond_0
    div-int/lit8 v4, v2, 0x4

    aput v3, v1, v4

    .line 87
    .end local v3    # "x":I
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 101
    .end local v2    # "i":I
    :cond_1
    return-object v1
.end method

.method public static find(I)Lcom/fasterxml/aalto/in/PName;
    .locals 1
    .param p0, "quad1"    # I

    .line 51
    sget v0, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->QUAD_XML:I

    if-ne p0, v0, :cond_0

    .line 52
    sget-object v0, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->NAME_XML:Lcom/fasterxml/aalto/in/PName1;

    return-object v0

    .line 54
    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public static find(II)Lcom/fasterxml/aalto/in/PName;
    .locals 1
    .param p0, "quad1"    # I
    .param p1, "quad2"    # I

    .line 59
    sget v0, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->QUAD_VERSION1:I

    if-ne p0, v0, :cond_0

    .line 60
    sget v0, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->QUAD_VERSION2:I

    if-ne p1, v0, :cond_1

    .line 61
    sget-object v0, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->NAME_VERSION:Lcom/fasterxml/aalto/in/PName2;

    return-object v0

    .line 63
    :cond_0
    sget v0, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->QUAD_ENCODING1:I

    if-ne p0, v0, :cond_1

    .line 64
    sget v0, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->QUAD_ENCODING2:I

    if-ne p1, v0, :cond_1

    .line 65
    sget-object v0, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->NAME_ENCODING:Lcom/fasterxml/aalto/in/PName2;

    return-object v0

    .line 68
    :cond_1
    const/4 v0, 0x0

    return-object v0
.end method

.method public static find(III)Lcom/fasterxml/aalto/in/PName;
    .locals 1
    .param p0, "quad1"    # I
    .param p1, "quad2"    # I
    .param p2, "quad3"    # I

    .line 73
    sget v0, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->QUAD_STANDALONE1:I

    if-ne p0, v0, :cond_0

    .line 74
    sget v0, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->QUAD_STANDALONE2:I

    if-ne p1, v0, :cond_0

    .line 75
    sget v0, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->QUAD_STANDALONE3:I

    if-ne p2, v0, :cond_0

    .line 76
    sget-object v0, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->NAME_STANDALONE:Lcom/fasterxml/aalto/in/PName3;

    return-object v0

    .line 80
    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method
