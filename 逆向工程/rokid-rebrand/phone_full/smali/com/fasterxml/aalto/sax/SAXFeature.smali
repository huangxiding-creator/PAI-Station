.class public final enum Lcom/fasterxml/aalto/sax/SAXFeature;
.super Ljava/lang/Enum;
.source "SAXFeature.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/fasterxml/aalto/sax/SAXFeature;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/fasterxml/aalto/sax/SAXFeature;

.field public static final enum EXTERNAL_GENERAL_ENTITIES:Lcom/fasterxml/aalto/sax/SAXFeature;

.field public static final enum EXTERNAL_PARAMETER_ENTITIES:Lcom/fasterxml/aalto/sax/SAXFeature;

.field public static final enum IS_STANDALONE:Lcom/fasterxml/aalto/sax/SAXFeature;

.field public static final enum LEXICAL_HANDLER_PARAMETER_ENTITIES:Lcom/fasterxml/aalto/sax/SAXFeature;

.field public static final enum NAMESPACES:Lcom/fasterxml/aalto/sax/SAXFeature;

.field public static final enum NAMESPACE_PREFIXES:Lcom/fasterxml/aalto/sax/SAXFeature;

.field public static final enum RESOLVE_DTD_URIS:Lcom/fasterxml/aalto/sax/SAXFeature;

.field public static final STD_FEATURE_PREFIX:Ljava/lang/String; = "http://xml.org/sax/features/"

.field public static final enum STRING_INTERNING:Lcom/fasterxml/aalto/sax/SAXFeature;

.field public static final enum UNICODE_NORMALIZATION_CHECKING:Lcom/fasterxml/aalto/sax/SAXFeature;

.field public static final enum USE_ATTRIBUTES2:Lcom/fasterxml/aalto/sax/SAXFeature;

.field public static final enum USE_ENTITY_RESOLVER2:Lcom/fasterxml/aalto/sax/SAXFeature;

.field public static final enum USE_LOCATOR2:Lcom/fasterxml/aalto/sax/SAXFeature;

.field public static final enum VALIDATION:Lcom/fasterxml/aalto/sax/SAXFeature;

.field public static final enum XMLNS_URIS:Lcom/fasterxml/aalto/sax/SAXFeature;

.field public static final enum XML_1_1:Lcom/fasterxml/aalto/sax/SAXFeature;


# instance fields
.field private final mSuffix:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 19

    .line 9
    new-instance v0, Lcom/fasterxml/aalto/sax/SAXFeature;

    const/4 v1, 0x0

    const-string v2, "external-general-entities"

    const-string v3, "EXTERNAL_GENERAL_ENTITIES"

    invoke-direct {v0, v3, v1, v2}, Lcom/fasterxml/aalto/sax/SAXFeature;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/fasterxml/aalto/sax/SAXFeature;->EXTERNAL_GENERAL_ENTITIES:Lcom/fasterxml/aalto/sax/SAXFeature;

    .line 10
    new-instance v0, Lcom/fasterxml/aalto/sax/SAXFeature;

    const/4 v1, 0x1

    const-string v2, "external-parameter-entities"

    const-string v3, "EXTERNAL_PARAMETER_ENTITIES"

    invoke-direct {v0, v3, v1, v2}, Lcom/fasterxml/aalto/sax/SAXFeature;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/fasterxml/aalto/sax/SAXFeature;->EXTERNAL_PARAMETER_ENTITIES:Lcom/fasterxml/aalto/sax/SAXFeature;

    .line 11
    new-instance v0, Lcom/fasterxml/aalto/sax/SAXFeature;

    const/4 v1, 0x2

    const-string v2, "is-standalone"

    const-string v3, "IS_STANDALONE"

    invoke-direct {v0, v3, v1, v2}, Lcom/fasterxml/aalto/sax/SAXFeature;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/fasterxml/aalto/sax/SAXFeature;->IS_STANDALONE:Lcom/fasterxml/aalto/sax/SAXFeature;

    .line 12
    new-instance v0, Lcom/fasterxml/aalto/sax/SAXFeature;

    const/4 v1, 0x3

    const-string v2, "lexical-handler/parameter-entities"

    const-string v3, "LEXICAL_HANDLER_PARAMETER_ENTITIES"

    invoke-direct {v0, v3, v1, v2}, Lcom/fasterxml/aalto/sax/SAXFeature;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/fasterxml/aalto/sax/SAXFeature;->LEXICAL_HANDLER_PARAMETER_ENTITIES:Lcom/fasterxml/aalto/sax/SAXFeature;

    .line 13
    new-instance v0, Lcom/fasterxml/aalto/sax/SAXFeature;

    const/4 v1, 0x4

    const-string v2, "namespaces"

    const-string v3, "NAMESPACES"

    invoke-direct {v0, v3, v1, v2}, Lcom/fasterxml/aalto/sax/SAXFeature;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/fasterxml/aalto/sax/SAXFeature;->NAMESPACES:Lcom/fasterxml/aalto/sax/SAXFeature;

    .line 14
    new-instance v0, Lcom/fasterxml/aalto/sax/SAXFeature;

    const/4 v1, 0x5

    const-string v2, "namespace-prefixes"

    const-string v3, "NAMESPACE_PREFIXES"

    invoke-direct {v0, v3, v1, v2}, Lcom/fasterxml/aalto/sax/SAXFeature;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/fasterxml/aalto/sax/SAXFeature;->NAMESPACE_PREFIXES:Lcom/fasterxml/aalto/sax/SAXFeature;

    .line 15
    new-instance v0, Lcom/fasterxml/aalto/sax/SAXFeature;

    const/4 v1, 0x6

    const-string v2, "resolve-dtd-uris"

    const-string v3, "RESOLVE_DTD_URIS"

    invoke-direct {v0, v3, v1, v2}, Lcom/fasterxml/aalto/sax/SAXFeature;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/fasterxml/aalto/sax/SAXFeature;->RESOLVE_DTD_URIS:Lcom/fasterxml/aalto/sax/SAXFeature;

    .line 16
    new-instance v0, Lcom/fasterxml/aalto/sax/SAXFeature;

    const/4 v1, 0x7

    const-string/jumbo v2, "string-interning"

    const-string v3, "STRING_INTERNING"

    invoke-direct {v0, v3, v1, v2}, Lcom/fasterxml/aalto/sax/SAXFeature;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/fasterxml/aalto/sax/SAXFeature;->STRING_INTERNING:Lcom/fasterxml/aalto/sax/SAXFeature;

    .line 17
    new-instance v0, Lcom/fasterxml/aalto/sax/SAXFeature;

    const/16 v1, 0x8

    const-string/jumbo v2, "unicode-normalization-checking"

    const-string v3, "UNICODE_NORMALIZATION_CHECKING"

    invoke-direct {v0, v3, v1, v2}, Lcom/fasterxml/aalto/sax/SAXFeature;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/fasterxml/aalto/sax/SAXFeature;->UNICODE_NORMALIZATION_CHECKING:Lcom/fasterxml/aalto/sax/SAXFeature;

    .line 18
    new-instance v0, Lcom/fasterxml/aalto/sax/SAXFeature;

    const/16 v1, 0x9

    const-string/jumbo v2, "use-attributes2"

    const-string v3, "USE_ATTRIBUTES2"

    invoke-direct {v0, v3, v1, v2}, Lcom/fasterxml/aalto/sax/SAXFeature;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/fasterxml/aalto/sax/SAXFeature;->USE_ATTRIBUTES2:Lcom/fasterxml/aalto/sax/SAXFeature;

    .line 19
    new-instance v0, Lcom/fasterxml/aalto/sax/SAXFeature;

    const/16 v1, 0xa

    const-string/jumbo v2, "use-locator2"

    const-string v3, "USE_LOCATOR2"

    invoke-direct {v0, v3, v1, v2}, Lcom/fasterxml/aalto/sax/SAXFeature;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/fasterxml/aalto/sax/SAXFeature;->USE_LOCATOR2:Lcom/fasterxml/aalto/sax/SAXFeature;

    .line 20
    new-instance v0, Lcom/fasterxml/aalto/sax/SAXFeature;

    const/16 v1, 0xb

    const-string/jumbo v2, "use-entity-resolver2"

    const-string v3, "USE_ENTITY_RESOLVER2"

    invoke-direct {v0, v3, v1, v2}, Lcom/fasterxml/aalto/sax/SAXFeature;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/fasterxml/aalto/sax/SAXFeature;->USE_ENTITY_RESOLVER2:Lcom/fasterxml/aalto/sax/SAXFeature;

    .line 21
    new-instance v0, Lcom/fasterxml/aalto/sax/SAXFeature;

    const/16 v1, 0xc

    const-string/jumbo v2, "validation"

    const-string v3, "VALIDATION"

    invoke-direct {v0, v3, v1, v2}, Lcom/fasterxml/aalto/sax/SAXFeature;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/fasterxml/aalto/sax/SAXFeature;->VALIDATION:Lcom/fasterxml/aalto/sax/SAXFeature;

    .line 22
    new-instance v0, Lcom/fasterxml/aalto/sax/SAXFeature;

    const/16 v1, 0xd

    const-string/jumbo v2, "xmlns-uris"

    const-string v3, "XMLNS_URIS"

    invoke-direct {v0, v3, v1, v2}, Lcom/fasterxml/aalto/sax/SAXFeature;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/fasterxml/aalto/sax/SAXFeature;->XMLNS_URIS:Lcom/fasterxml/aalto/sax/SAXFeature;

    .line 23
    new-instance v0, Lcom/fasterxml/aalto/sax/SAXFeature;

    const/16 v1, 0xe

    const-string/jumbo v2, "xml-1.1"

    const-string v3, "XML_1_1"

    invoke-direct {v0, v3, v1, v2}, Lcom/fasterxml/aalto/sax/SAXFeature;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/fasterxml/aalto/sax/SAXFeature;->XML_1_1:Lcom/fasterxml/aalto/sax/SAXFeature;

    .line 7
    sget-object v4, Lcom/fasterxml/aalto/sax/SAXFeature;->EXTERNAL_GENERAL_ENTITIES:Lcom/fasterxml/aalto/sax/SAXFeature;

    sget-object v5, Lcom/fasterxml/aalto/sax/SAXFeature;->EXTERNAL_PARAMETER_ENTITIES:Lcom/fasterxml/aalto/sax/SAXFeature;

    sget-object v6, Lcom/fasterxml/aalto/sax/SAXFeature;->IS_STANDALONE:Lcom/fasterxml/aalto/sax/SAXFeature;

    sget-object v7, Lcom/fasterxml/aalto/sax/SAXFeature;->LEXICAL_HANDLER_PARAMETER_ENTITIES:Lcom/fasterxml/aalto/sax/SAXFeature;

    sget-object v8, Lcom/fasterxml/aalto/sax/SAXFeature;->NAMESPACES:Lcom/fasterxml/aalto/sax/SAXFeature;

    sget-object v9, Lcom/fasterxml/aalto/sax/SAXFeature;->NAMESPACE_PREFIXES:Lcom/fasterxml/aalto/sax/SAXFeature;

    sget-object v10, Lcom/fasterxml/aalto/sax/SAXFeature;->RESOLVE_DTD_URIS:Lcom/fasterxml/aalto/sax/SAXFeature;

    sget-object v11, Lcom/fasterxml/aalto/sax/SAXFeature;->STRING_INTERNING:Lcom/fasterxml/aalto/sax/SAXFeature;

    sget-object v12, Lcom/fasterxml/aalto/sax/SAXFeature;->UNICODE_NORMALIZATION_CHECKING:Lcom/fasterxml/aalto/sax/SAXFeature;

    sget-object v13, Lcom/fasterxml/aalto/sax/SAXFeature;->USE_ATTRIBUTES2:Lcom/fasterxml/aalto/sax/SAXFeature;

    sget-object v14, Lcom/fasterxml/aalto/sax/SAXFeature;->USE_LOCATOR2:Lcom/fasterxml/aalto/sax/SAXFeature;

    sget-object v15, Lcom/fasterxml/aalto/sax/SAXFeature;->USE_ENTITY_RESOLVER2:Lcom/fasterxml/aalto/sax/SAXFeature;

    sget-object v16, Lcom/fasterxml/aalto/sax/SAXFeature;->VALIDATION:Lcom/fasterxml/aalto/sax/SAXFeature;

    sget-object v17, Lcom/fasterxml/aalto/sax/SAXFeature;->XMLNS_URIS:Lcom/fasterxml/aalto/sax/SAXFeature;

    sget-object v18, Lcom/fasterxml/aalto/sax/SAXFeature;->XML_1_1:Lcom/fasterxml/aalto/sax/SAXFeature;

    filled-new-array/range {v4 .. v18}, [Lcom/fasterxml/aalto/sax/SAXFeature;

    move-result-object v0

    sput-object v0, Lcom/fasterxml/aalto/sax/SAXFeature;->$VALUES:[Lcom/fasterxml/aalto/sax/SAXFeature;

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

    .line 30
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    .line 31
    iput-object p3, p0, Lcom/fasterxml/aalto/sax/SAXFeature;->mSuffix:Ljava/lang/String;

    .line 32
    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/fasterxml/aalto/sax/SAXFeature;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 7
    const-class v0, Lcom/fasterxml/aalto/sax/SAXFeature;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/fasterxml/aalto/sax/SAXFeature;

    return-object v0
.end method

.method public static values()[Lcom/fasterxml/aalto/sax/SAXFeature;
    .locals 1

    .line 7
    sget-object v0, Lcom/fasterxml/aalto/sax/SAXFeature;->$VALUES:[Lcom/fasterxml/aalto/sax/SAXFeature;

    invoke-virtual {v0}, [Lcom/fasterxml/aalto/sax/SAXFeature;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/fasterxml/aalto/sax/SAXFeature;

    return-object v0
.end method


# virtual methods
.method public getSuffix()Ljava/lang/String;
    .locals 1

    .line 34
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXFeature;->mSuffix:Ljava/lang/String;

    return-object v0
.end method

.method public toExternal()Ljava/lang/String;
    .locals 2

    .line 36
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "http://xml.org/sax/features/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/fasterxml/aalto/sax/SAXFeature;->mSuffix:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
