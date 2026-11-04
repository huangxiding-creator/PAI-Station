.class Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures$DefaultHolder;
.super Ljava/lang/Object;
.source "DatatypeFeatures.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "DefaultHolder"
.end annotation


# static fields
.field private static final DEFAULT_FEATURES:Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .line 253
    new-instance v0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;

    .line 254
    invoke-static {}, Lcom/fasterxml/jackson/databind/cfg/EnumFeature;->values()[Lcom/fasterxml/jackson/databind/cfg/EnumFeature;

    move-result-object v1

    invoke-static {v1}, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures$DefaultHolder;->collectDefaults([Ljava/lang/Enum;)I

    move-result v1

    .line 255
    invoke-static {}, Lcom/fasterxml/jackson/databind/cfg/JsonNodeFeature;->values()[Lcom/fasterxml/jackson/databind/cfg/JsonNodeFeature;

    move-result-object v2

    invoke-static {v2}, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures$DefaultHolder;->collectDefaults([Ljava/lang/Enum;)I

    move-result v2

    const/4 v3, 0x0

    invoke-direct {v0, v1, v3, v2, v3}, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;-><init>(IIII)V

    sput-object v0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures$DefaultHolder;->DEFAULT_FEATURES:Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;

    .line 257
    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 249
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static collectDefaults([Ljava/lang/Enum;)I
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<F:",
            "Ljava/lang/Enum<",
            "TF;>;:",
            "Lcom/fasterxml/jackson/core/util/JacksonFeature;",
            ">([TF;)I"
        }
    .end annotation

    .line 261
    .local p0, "features":[Ljava/lang/Enum;, "[TF;"
    const/4 v0, 0x0

    .line 262
    .local v0, "flags":I
    array-length v1, p0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_1

    aget-object v3, p0, v2

    .line 263
    .local v3, "f":Lcom/fasterxml/jackson/core/util/JacksonFeature;
    invoke-interface {v3}, Lcom/fasterxml/jackson/core/util/JacksonFeature;->enabledByDefault()Z

    move-result v4

    if-eqz v4, :cond_0

    .line 264
    invoke-interface {v3}, Lcom/fasterxml/jackson/core/util/JacksonFeature;->getMask()I

    move-result v4

    or-int/2addr v0, v4

    .line 262
    .end local v3    # "f":Lcom/fasterxml/jackson/core/util/JacksonFeature;
    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 267
    :cond_1
    return v0
.end method

.method public static getDefault()Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;
    .locals 1

    .line 271
    sget-object v0, Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures$DefaultHolder;->DEFAULT_FEATURES:Lcom/fasterxml/jackson/databind/cfg/DatatypeFeatures;

    return-object v0
.end method
