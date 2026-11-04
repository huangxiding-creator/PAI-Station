.class public final Lcom/fasterxml/aalto/sax/SAXUtil;
.super Ljava/lang/Object;
.source "SAXUtil.java"


# static fields
.field static final sStdFeatures:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Lcom/fasterxml/aalto/sax/SAXFeature;",
            ">;"
        }
    .end annotation
.end field

.field static final sStdProperties:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Lcom/fasterxml/aalto/sax/SAXProperty;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 7

    .line 29
    invoke-static {}, Lcom/fasterxml/aalto/sax/SAXFeature;->values()[Lcom/fasterxml/aalto/sax/SAXFeature;

    move-result-object v0

    .line 30
    .local v0, "feats":[Lcom/fasterxml/aalto/sax/SAXFeature;
    new-instance v1, Ljava/util/HashMap;

    array-length v2, v0

    invoke-direct {v1, v2}, Ljava/util/HashMap;-><init>(I)V

    sput-object v1, Lcom/fasterxml/aalto/sax/SAXUtil;->sStdFeatures:Ljava/util/HashMap;

    .line 31
    array-length v1, v0

    const/4 v2, 0x0

    move v3, v2

    :goto_0
    if-ge v3, v1, :cond_0

    aget-object v4, v0, v3

    .line 32
    .local v4, "feat":Lcom/fasterxml/aalto/sax/SAXFeature;
    sget-object v5, Lcom/fasterxml/aalto/sax/SAXUtil;->sStdFeatures:Ljava/util/HashMap;

    invoke-virtual {v4}, Lcom/fasterxml/aalto/sax/SAXFeature;->getSuffix()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6, v4}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 31
    .end local v4    # "feat":Lcom/fasterxml/aalto/sax/SAXFeature;
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 38
    .end local v0    # "feats":[Lcom/fasterxml/aalto/sax/SAXFeature;
    :cond_0
    invoke-static {}, Lcom/fasterxml/aalto/sax/SAXProperty;->values()[Lcom/fasterxml/aalto/sax/SAXProperty;

    move-result-object v0

    .line 39
    .local v0, "props":[Lcom/fasterxml/aalto/sax/SAXProperty;
    new-instance v1, Ljava/util/HashMap;

    array-length v3, v0

    invoke-direct {v1, v3}, Ljava/util/HashMap;-><init>(I)V

    sput-object v1, Lcom/fasterxml/aalto/sax/SAXUtil;->sStdProperties:Ljava/util/HashMap;

    .line 40
    array-length v1, v0

    :goto_1
    if-ge v2, v1, :cond_1

    aget-object v3, v0, v2

    .line 41
    .local v3, "prop":Lcom/fasterxml/aalto/sax/SAXProperty;
    sget-object v4, Lcom/fasterxml/aalto/sax/SAXUtil;->sStdProperties:Ljava/util/HashMap;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/sax/SAXProperty;->getSuffix()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 40
    .end local v3    # "prop":Lcom/fasterxml/aalto/sax/SAXProperty;
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 43
    .end local v0    # "props":[Lcom/fasterxml/aalto/sax/SAXProperty;
    :cond_1
    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 45
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static findStdFeature(Ljava/lang/String;)Lcom/fasterxml/aalto/sax/SAXFeature;
    .locals 2
    .param p0, "featURI"    # Ljava/lang/String;

    .line 49
    const-string v0, "http://xml.org/sax/features/"

    invoke-virtual {p0, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 50
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    invoke-virtual {p0, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    .line 51
    .local v0, "suffix":Ljava/lang/String;
    sget-object v1, Lcom/fasterxml/aalto/sax/SAXUtil;->sStdFeatures:Ljava/util/HashMap;

    invoke-virtual {v1, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/fasterxml/aalto/sax/SAXFeature;

    return-object v1

    .line 53
    .end local v0    # "suffix":Ljava/lang/String;
    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public static findStdProperty(Ljava/lang/String;)Lcom/fasterxml/aalto/sax/SAXProperty;
    .locals 2
    .param p0, "featURI"    # Ljava/lang/String;

    .line 58
    const-string v0, "http://xml.org/sax/properties/"

    invoke-virtual {p0, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 59
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    invoke-virtual {p0, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    .line 60
    .local v0, "suffix":Ljava/lang/String;
    sget-object v1, Lcom/fasterxml/aalto/sax/SAXUtil;->sStdProperties:Ljava/util/HashMap;

    invoke-virtual {v1, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/fasterxml/aalto/sax/SAXProperty;

    return-object v1

    .line 62
    .end local v0    # "suffix":Ljava/lang/String;
    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public static getFixedStdFeatureValue(Lcom/fasterxml/aalto/sax/SAXFeature;)Ljava/lang/Boolean;
    .locals 2
    .param p0, "stdFeat"    # Lcom/fasterxml/aalto/sax/SAXFeature;

    .line 73
    sget-object v0, Lcom/fasterxml/aalto/sax/SAXUtil$1;->$SwitchMap$com$fasterxml$aalto$sax$SAXFeature:[I

    invoke-virtual {p0}, Lcom/fasterxml/aalto/sax/SAXFeature;->ordinal()I

    move-result v1

    aget v0, v0, v1

    packed-switch v0, :pswitch_data_0

    goto :goto_0

    .line 112
    :pswitch_0
    sget-object v0, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    return-object v0

    .line 108
    :pswitch_1
    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    return-object v0

    .line 104
    :pswitch_2
    sget-object v0, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    return-object v0

    .line 100
    :pswitch_3
    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    return-object v0

    .line 95
    :pswitch_4
    sget-object v0, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    return-object v0

    .line 91
    :pswitch_5
    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    return-object v0

    .line 88
    :pswitch_6
    sget-object v0, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    return-object v0

    .line 86
    :pswitch_7
    sget-object v0, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    return-object v0

    .line 84
    :pswitch_8
    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    return-object v0

    .line 82
    :pswitch_9
    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    return-object v0

    .line 79
    :pswitch_a
    goto :goto_0

    .line 77
    :pswitch_b
    sget-object v0, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    return-object v0

    .line 75
    :pswitch_c
    sget-object v0, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    return-object v0

    .line 115
    :goto_0
    const/4 v0, 0x0

    return-object v0

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_c
        :pswitch_b
        :pswitch_a
        :pswitch_9
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_3
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public static reportUnknownFeature(Ljava/lang/String;)V
    .locals 3
    .param p0, "name"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/xml/sax/SAXNotRecognizedException;
        }
    .end annotation

    .line 121
    new-instance v0, Lorg/xml/sax/SAXNotRecognizedException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Feature \'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\' not recognized"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lorg/xml/sax/SAXNotRecognizedException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static reportUnknownProperty(Ljava/lang/String;)V
    .locals 3
    .param p0, "name"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/xml/sax/SAXNotRecognizedException;
        }
    .end annotation

    .line 127
    new-instance v0, Lorg/xml/sax/SAXNotRecognizedException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Property \'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\' not recognized"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lorg/xml/sax/SAXNotRecognizedException;-><init>(Ljava/lang/String;)V

    throw v0
.end method
