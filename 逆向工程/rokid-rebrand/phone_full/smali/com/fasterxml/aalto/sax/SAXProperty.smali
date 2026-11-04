.class public final enum Lcom/fasterxml/aalto/sax/SAXProperty;
.super Ljava/lang/Enum;
.source "SAXProperty.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/fasterxml/aalto/sax/SAXProperty;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/fasterxml/aalto/sax/SAXProperty;

.field public static final enum DECLARATION_HANDLER:Lcom/fasterxml/aalto/sax/SAXProperty;

.field public static final enum DOCUMENT_XML_VERSION:Lcom/fasterxml/aalto/sax/SAXProperty;

.field public static final enum DOM_NODE:Lcom/fasterxml/aalto/sax/SAXProperty;

.field public static final enum LEXICAL_HANDLER:Lcom/fasterxml/aalto/sax/SAXProperty;

.field public static final STD_PROPERTY_PREFIX:Ljava/lang/String; = "http://xml.org/sax/properties/"

.field public static final enum XML_STRING:Lcom/fasterxml/aalto/sax/SAXProperty;


# instance fields
.field private final mSuffix:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .line 9
    new-instance v0, Lcom/fasterxml/aalto/sax/SAXProperty;

    const/4 v1, 0x0

    const-string v2, "declaration-handler"

    const-string v3, "DECLARATION_HANDLER"

    invoke-direct {v0, v3, v1, v2}, Lcom/fasterxml/aalto/sax/SAXProperty;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/fasterxml/aalto/sax/SAXProperty;->DECLARATION_HANDLER:Lcom/fasterxml/aalto/sax/SAXProperty;

    .line 10
    new-instance v0, Lcom/fasterxml/aalto/sax/SAXProperty;

    const/4 v1, 0x1

    const-string v2, "document-xml-version"

    const-string v3, "DOCUMENT_XML_VERSION"

    invoke-direct {v0, v3, v1, v2}, Lcom/fasterxml/aalto/sax/SAXProperty;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/fasterxml/aalto/sax/SAXProperty;->DOCUMENT_XML_VERSION:Lcom/fasterxml/aalto/sax/SAXProperty;

    .line 11
    new-instance v0, Lcom/fasterxml/aalto/sax/SAXProperty;

    const/4 v1, 0x2

    const-string v2, "dom-node"

    const-string v3, "DOM_NODE"

    invoke-direct {v0, v3, v1, v2}, Lcom/fasterxml/aalto/sax/SAXProperty;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/fasterxml/aalto/sax/SAXProperty;->DOM_NODE:Lcom/fasterxml/aalto/sax/SAXProperty;

    .line 12
    new-instance v0, Lcom/fasterxml/aalto/sax/SAXProperty;

    const/4 v1, 0x3

    const-string v2, "lexical-handler"

    const-string v3, "LEXICAL_HANDLER"

    invoke-direct {v0, v3, v1, v2}, Lcom/fasterxml/aalto/sax/SAXProperty;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/fasterxml/aalto/sax/SAXProperty;->LEXICAL_HANDLER:Lcom/fasterxml/aalto/sax/SAXProperty;

    .line 13
    new-instance v0, Lcom/fasterxml/aalto/sax/SAXProperty;

    const/4 v1, 0x4

    const-string/jumbo v2, "xml-string"

    const-string v3, "XML_STRING"

    invoke-direct {v0, v3, v1, v2}, Lcom/fasterxml/aalto/sax/SAXProperty;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/fasterxml/aalto/sax/SAXProperty;->XML_STRING:Lcom/fasterxml/aalto/sax/SAXProperty;

    .line 7
    sget-object v0, Lcom/fasterxml/aalto/sax/SAXProperty;->DECLARATION_HANDLER:Lcom/fasterxml/aalto/sax/SAXProperty;

    sget-object v1, Lcom/fasterxml/aalto/sax/SAXProperty;->DOCUMENT_XML_VERSION:Lcom/fasterxml/aalto/sax/SAXProperty;

    sget-object v2, Lcom/fasterxml/aalto/sax/SAXProperty;->DOM_NODE:Lcom/fasterxml/aalto/sax/SAXProperty;

    sget-object v3, Lcom/fasterxml/aalto/sax/SAXProperty;->LEXICAL_HANDLER:Lcom/fasterxml/aalto/sax/SAXProperty;

    sget-object v4, Lcom/fasterxml/aalto/sax/SAXProperty;->XML_STRING:Lcom/fasterxml/aalto/sax/SAXProperty;

    filled-new-array {v0, v1, v2, v3, v4}, [Lcom/fasterxml/aalto/sax/SAXProperty;

    move-result-object v0

    sput-object v0, Lcom/fasterxml/aalto/sax/SAXProperty;->$VALUES:[Lcom/fasterxml/aalto/sax/SAXProperty;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;ILjava/lang/String;)V
    .locals 0
    .param p3, "suffix"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .line 20
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    .line 21
    iput-object p3, p0, Lcom/fasterxml/aalto/sax/SAXProperty;->mSuffix:Ljava/lang/String;

    .line 22
    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/fasterxml/aalto/sax/SAXProperty;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 7
    const-class v0, Lcom/fasterxml/aalto/sax/SAXProperty;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/fasterxml/aalto/sax/SAXProperty;

    return-object v0
.end method

.method public static values()[Lcom/fasterxml/aalto/sax/SAXProperty;
    .locals 1

    .line 7
    sget-object v0, Lcom/fasterxml/aalto/sax/SAXProperty;->$VALUES:[Lcom/fasterxml/aalto/sax/SAXProperty;

    invoke-virtual {v0}, [Lcom/fasterxml/aalto/sax/SAXProperty;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/fasterxml/aalto/sax/SAXProperty;

    return-object v0
.end method


# virtual methods
.method public getSuffix()Ljava/lang/String;
    .locals 1

    .line 24
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXProperty;->mSuffix:Ljava/lang/String;

    return-object v0
.end method

.method public toExternal()Ljava/lang/String;
    .locals 2

    .line 26
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "http://xml.org/sax/properties/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/fasterxml/aalto/sax/SAXProperty;->mSuffix:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
