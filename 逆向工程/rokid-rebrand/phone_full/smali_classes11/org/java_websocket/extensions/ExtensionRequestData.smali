.class public Lorg/java_websocket/extensions/ExtensionRequestData;
.super Ljava/lang/Object;
.source "ExtensionRequestData.java"


# static fields
.field public static final EMPTY_VALUE:Ljava/lang/String; = ""


# instance fields
.field private extensionName:Ljava/lang/String;

.field private extensionParameters:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method private constructor <init>()V
    .locals 1

    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 14
    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    iput-object v0, p0, Lorg/java_websocket/extensions/ExtensionRequestData;->extensionParameters:Ljava/util/Map;

    .line 15
    return-void
.end method

.method public static parseExtensionRequest(Ljava/lang/String;)Lorg/java_websocket/extensions/ExtensionRequestData;
    .locals 10
    .param p0, "extensionRequest"    # Ljava/lang/String;

    .line 18
    new-instance v0, Lorg/java_websocket/extensions/ExtensionRequestData;

    invoke-direct {v0}, Lorg/java_websocket/extensions/ExtensionRequestData;-><init>()V

    .line 19
    .local v0, "extensionData":Lorg/java_websocket/extensions/ExtensionRequestData;
    const-string v1, ";"

    invoke-virtual {p0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    .line 20
    .local v1, "parts":[Ljava/lang/String;
    const/4 v2, 0x0

    aget-object v3, v1, v2

    invoke-virtual {v3}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v3

    iput-object v3, v0, Lorg/java_websocket/extensions/ExtensionRequestData;->extensionName:Ljava/lang/String;

    .line 22
    const/4 v3, 0x1

    .local v3, "i":I
    :goto_0
    array-length v4, v1

    if-ge v3, v4, :cond_4

    .line 23
    aget-object v4, v1, v3

    const-string v5, "="

    invoke-virtual {v4, v5}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v4

    .line 24
    .local v4, "keyValue":[Ljava/lang/String;
    const-string v5, ""

    .line 27
    .local v5, "value":Ljava/lang/String;
    array-length v6, v4

    const/4 v7, 0x1

    if-le v6, v7, :cond_3

    .line 28
    aget-object v6, v4, v7

    invoke-virtual {v6}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v6

    .line 31
    .local v6, "tempValue":Ljava/lang/String;
    const-string v8, "\""

    invoke-virtual {v6, v8}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_0

    invoke-virtual {v6, v8}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v8

    if-nez v8, :cond_1

    .line 32
    :cond_0
    const-string v8, "\'"

    invoke-virtual {v6, v8}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_2

    invoke-virtual {v6, v8}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_2

    .line 33
    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v8

    const/4 v9, 0x2

    if-le v8, v9, :cond_2

    .line 34
    :cond_1
    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v8

    sub-int/2addr v8, v7

    invoke-virtual {v6, v7, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v6

    .line 37
    :cond_2
    move-object v5, v6

    .line 40
    .end local v6    # "tempValue":Ljava/lang/String;
    :cond_3
    iget-object v6, v0, Lorg/java_websocket/extensions/ExtensionRequestData;->extensionParameters:Ljava/util/Map;

    aget-object v7, v4, v2

    invoke-virtual {v7}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v7

    invoke-interface {v6, v7, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 22
    .end local v4    # "keyValue":[Ljava/lang/String;
    .end local v5    # "value":Ljava/lang/String;
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 43
    .end local v3    # "i":I
    :cond_4
    return-object v0
.end method


# virtual methods
.method public getExtensionName()Ljava/lang/String;
    .locals 1

    .line 47
    iget-object v0, p0, Lorg/java_websocket/extensions/ExtensionRequestData;->extensionName:Ljava/lang/String;

    return-object v0
.end method

.method public getExtensionParameters()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 51
    iget-object v0, p0, Lorg/java_websocket/extensions/ExtensionRequestData;->extensionParameters:Ljava/util/Map;

    return-object v0
.end method
