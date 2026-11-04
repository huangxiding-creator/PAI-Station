.class public Lcom/fasterxml/aalto/sax/SAXParserFactoryImpl;
.super Ljavax/xml/parsers/SAXParserFactory;
.source "SAXParserFactoryImpl.java"


# instance fields
.field final mStaxFactory:Lcom/fasterxml/aalto/stax/InputFactoryImpl;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 42
    invoke-direct {p0}, Ljavax/xml/parsers/SAXParserFactory;-><init>()V

    .line 45
    new-instance v0, Lcom/fasterxml/aalto/stax/InputFactoryImpl;

    invoke-direct {v0}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;-><init>()V

    iput-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserFactoryImpl;->mStaxFactory:Lcom/fasterxml/aalto/stax/InputFactoryImpl;

    .line 46
    return-void
.end method

.method public static newInstance()Ljavax/xml/parsers/SAXParserFactory;
    .locals 1

    .line 49
    new-instance v0, Lcom/fasterxml/aalto/sax/SAXParserFactoryImpl;

    invoke-direct {v0}, Lcom/fasterxml/aalto/sax/SAXParserFactoryImpl;-><init>()V

    return-object v0
.end method


# virtual methods
.method public getFeature(Ljava/lang/String;)Z
    .locals 4
    .param p1, "name"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/xml/sax/SAXNotRecognizedException;,
            Lorg/xml/sax/SAXNotSupportedException;
        }
    .end annotation

    .line 57
    invoke-static {p1}, Lcom/fasterxml/aalto/sax/SAXUtil;->findStdFeature(Ljava/lang/String;)Lcom/fasterxml/aalto/sax/SAXFeature;

    move-result-object v0

    .line 58
    .local v0, "stdFeat":Lcom/fasterxml/aalto/sax/SAXFeature;
    if-eqz v0, :cond_1

    .line 60
    invoke-static {v0}, Lcom/fasterxml/aalto/sax/SAXUtil;->getFixedStdFeatureValue(Lcom/fasterxml/aalto/sax/SAXFeature;)Ljava/lang/Boolean;

    move-result-object v1

    .line 61
    .local v1, "b":Ljava/lang/Boolean;
    if-eqz v1, :cond_0

    .line 62
    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v2

    return v2

    .line 65
    :cond_0
    sget-object v2, Lcom/fasterxml/aalto/sax/SAXParserFactoryImpl$1;->$SwitchMap$com$fasterxml$aalto$sax$SAXFeature:[I

    invoke-virtual {v0}, Lcom/fasterxml/aalto/sax/SAXFeature;->ordinal()I

    move-result v3

    aget v2, v2, v3

    packed-switch v2, :pswitch_data_0

    .line 70
    .end local v1    # "b":Ljava/lang/Boolean;
    goto :goto_0

    .line 67
    .restart local v1    # "b":Ljava/lang/Boolean;
    :pswitch_0
    const/4 v2, 0x1

    return v2

    .line 71
    .end local v1    # "b":Ljava/lang/Boolean;
    :cond_1
    const-string v1, "com.fasterxml.aalto.retainAttributeGeneralEntities"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 72
    sget-object v2, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    iget-object v3, p0, Lcom/fasterxml/aalto/sax/SAXParserFactoryImpl;->mStaxFactory:Lcom/fasterxml/aalto/stax/InputFactoryImpl;

    invoke-virtual {v3, v1}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->getProperty(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v1

    return v1

    .line 77
    :cond_2
    :goto_0
    invoke-static {p1}, Lcom/fasterxml/aalto/sax/SAXUtil;->reportUnknownFeature(Ljava/lang/String;)V

    .line 78
    const/4 v1, 0x0

    return v1

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
    .end packed-switch
.end method

.method public newSAXParser()Ljavax/xml/parsers/SAXParser;
    .locals 2

    .line 83
    new-instance v0, Lcom/fasterxml/aalto/sax/SAXParserImpl;

    iget-object v1, p0, Lcom/fasterxml/aalto/sax/SAXParserFactoryImpl;->mStaxFactory:Lcom/fasterxml/aalto/stax/InputFactoryImpl;

    invoke-direct {v0, v1}, Lcom/fasterxml/aalto/sax/SAXParserImpl;-><init>(Lcom/fasterxml/aalto/stax/InputFactoryImpl;)V

    return-object v0
.end method

.method public setFeature(Ljava/lang/String;Z)V
    .locals 5
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "enabled"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/xml/sax/SAXNotRecognizedException;,
            Lorg/xml/sax/SAXNotSupportedException;
        }
    .end annotation

    .line 91
    invoke-static {p1}, Lcom/fasterxml/aalto/sax/SAXUtil;->findStdFeature(Ljava/lang/String;)Lcom/fasterxml/aalto/sax/SAXFeature;

    move-result-object v0

    .line 92
    .local v0, "stdFeat":Lcom/fasterxml/aalto/sax/SAXFeature;
    if-eqz v0, :cond_1

    .line 95
    sget-object v1, Lcom/fasterxml/aalto/sax/SAXParserFactoryImpl$1;->$SwitchMap$com$fasterxml$aalto$sax$SAXFeature:[I

    invoke-virtual {v0}, Lcom/fasterxml/aalto/sax/SAXFeature;->ordinal()I

    move-result v2

    aget v1, v1, v2

    packed-switch v1, :pswitch_data_0

    .line 145
    const/4 v1, 0x0

    .local v1, "ok":Z
    goto :goto_0

    .line 142
    .end local v1    # "ok":Z
    :pswitch_0
    xor-int/lit8 v1, p2, 0x1

    .line 143
    .restart local v1    # "ok":Z
    goto :goto_0

    .line 138
    .end local v1    # "ok":Z
    :pswitch_1
    const/4 v1, 0x1

    .line 139
    .restart local v1    # "ok":Z
    goto :goto_0

    .line 134
    .end local v1    # "ok":Z
    :pswitch_2
    xor-int/lit8 v1, p2, 0x1

    .line 135
    .restart local v1    # "ok":Z
    goto :goto_0

    .line 130
    .end local v1    # "ok":Z
    :pswitch_3
    const/4 v1, 0x1

    .line 131
    .restart local v1    # "ok":Z
    goto :goto_0

    .line 124
    .end local v1    # "ok":Z
    :pswitch_4
    const/4 v1, 0x0

    .line 125
    .restart local v1    # "ok":Z
    goto :goto_0

    .line 120
    .end local v1    # "ok":Z
    :pswitch_5
    const/4 v1, 0x1

    .line 121
    .restart local v1    # "ok":Z
    goto :goto_0

    .line 115
    .end local v1    # "ok":Z
    :pswitch_6
    const/4 v1, 0x1

    .line 116
    .restart local v1    # "ok":Z
    goto :goto_0

    .line 112
    .end local v1    # "ok":Z
    :pswitch_7
    xor-int/lit8 v1, p2, 0x1

    .line 113
    .restart local v1    # "ok":Z
    goto :goto_0

    .line 109
    .end local v1    # "ok":Z
    :pswitch_8
    move v1, p2

    .line 110
    .restart local v1    # "ok":Z
    goto :goto_0

    .line 106
    .end local v1    # "ok":Z
    :pswitch_9
    const/4 v1, 0x1

    .line 107
    .restart local v1    # "ok":Z
    goto :goto_0

    .line 100
    .end local v1    # "ok":Z
    :pswitch_a
    xor-int/lit8 v1, p2, 0x1

    .line 101
    .restart local v1    # "ok":Z
    goto :goto_0

    .line 97
    .end local v1    # "ok":Z
    :pswitch_b
    xor-int/lit8 v1, p2, 0x1

    .line 98
    .restart local v1    # "ok":Z
    goto :goto_0

    .line 103
    .end local v1    # "ok":Z
    :pswitch_c
    const/4 v1, 0x1

    .line 104
    .restart local v1    # "ok":Z
    nop

    .line 147
    :goto_0
    if-eqz v1, :cond_0

    .line 150
    return-void

    .line 148
    :cond_0
    new-instance v2, Lorg/xml/sax/SAXNotSupportedException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Setting std feature "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " to "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " not supported"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Lorg/xml/sax/SAXNotSupportedException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 153
    .end local v1    # "ok":Z
    :cond_1
    const-string v1, "com.fasterxml.aalto.retainAttributeGeneralEntities"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 154
    iget-object v2, p0, Lcom/fasterxml/aalto/sax/SAXParserFactoryImpl;->mStaxFactory:Lcom/fasterxml/aalto/stax/InputFactoryImpl;

    invoke-static {p2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v2, v1, v3}, Lcom/fasterxml/aalto/stax/InputFactoryImpl;->setProperty(Ljava/lang/String;Ljava/lang/Object;)V

    .line 155
    return-void

    .line 160
    :cond_2
    invoke-static {p1}, Lcom/fasterxml/aalto/sax/SAXUtil;->reportUnknownFeature(Ljava/lang/String;)V

    .line 161
    return-void

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

.method public setNamespaceAware(Z)V
    .locals 2
    .param p1, "awareness"    # Z

    .line 166
    if-eqz p1, :cond_0

    .line 169
    invoke-super {p0, p1}, Ljavax/xml/parsers/SAXParserFactory;->setNamespaceAware(Z)V

    .line 170
    return-void

    .line 167
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Non-namespace-aware mode not implemented"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public setValidating(Z)V
    .locals 2
    .param p1, "value"    # Z

    .line 175
    if-nez p1, :cond_0

    .line 178
    invoke-super {p0, p1}, Ljavax/xml/parsers/SAXParserFactory;->setValidating(Z)V

    .line 179
    return-void

    .line 176
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Validating mode not implemented"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method
