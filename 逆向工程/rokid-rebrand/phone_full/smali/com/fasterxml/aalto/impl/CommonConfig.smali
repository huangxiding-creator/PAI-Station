.class public abstract Lcom/fasterxml/aalto/impl/CommonConfig;
.super Ljava/lang/Object;
.source "CommonConfig.java"


# static fields
.field protected static final IMPL_NAME:Ljava/lang/String; = "aalto"

.field protected static final IMPL_VERSION:Ljava/lang/String; = "0.9"

.field static final PROP_IMPL_NAME:I = 0x1

.field static final PROP_IMPL_VERSION:I = 0x2

.field static final PROP_SUPPORTS_XML11:I = 0x3

.field static final PROP_SUPPORTS_XMLID:I = 0x4

.field static final sStdProperties:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field protected _flagMods:I

.field protected _flags:I


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .line 48
    new-instance v0, Ljava/util/HashMap;

    const/16 v1, 0x10

    invoke-direct {v0, v1}, Ljava/util/HashMap;-><init>(I)V

    sput-object v0, Lcom/fasterxml/aalto/impl/CommonConfig;->sStdProperties:Ljava/util/HashMap;

    .line 51
    sget-object v0, Lcom/fasterxml/aalto/impl/CommonConfig;->sStdProperties:Ljava/util/HashMap;

    .line 52
    const/4 v1, 0x1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    .line 51
    const-string v2, "org.codehaus.stax2.implName"

    invoke-virtual {v0, v2, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 53
    sget-object v0, Lcom/fasterxml/aalto/impl/CommonConfig;->sStdProperties:Ljava/util/HashMap;

    .line 54
    const/4 v2, 0x2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    .line 53
    const-string v3, "org.codehaus.stax2.implVersion"

    invoke-virtual {v0, v3, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 57
    sget-object v0, Lcom/fasterxml/aalto/impl/CommonConfig;->sStdProperties:Ljava/util/HashMap;

    .line 58
    const/4 v2, 0x3

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    .line 57
    const-string v3, "org.codehaus.stax2.supportsXml11"

    invoke-virtual {v0, v3, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 61
    sget-object v0, Lcom/fasterxml/aalto/impl/CommonConfig;->sStdProperties:Ljava/util/HashMap;

    .line 62
    const/4 v2, 0x4

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    .line 61
    const-string v3, "org.codehaus.stax2.supportXmlId"

    invoke-virtual {v0, v3, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 68
    sget-object v0, Lcom/fasterxml/aalto/impl/CommonConfig;->sStdProperties:Ljava/util/HashMap;

    .line 69
    nop

    .line 68
    const-string v2, "http://java.sun.com/xml/stream/properties/implementation-name"

    invoke-virtual {v0, v2, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 70
    return-void
.end method

.method protected constructor <init>(II)V
    .locals 0
    .param p1, "flags"    # I
    .param p2, "flagMods"    # I

    .line 84
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 85
    iput p1, p0, Lcom/fasterxml/aalto/impl/CommonConfig;->_flags:I

    .line 86
    iput p2, p0, Lcom/fasterxml/aalto/impl/CommonConfig;->_flagMods:I

    .line 87
    return-void
.end method


# virtual methods
.method public abstract getActualEncoding()Ljava/lang/String;
.end method

.method public abstract getExternalEncoding()Ljava/lang/String;
.end method

.method public getProperty(Ljava/lang/String;Z)Ljava/lang/Object;
    .locals 4
    .param p1, "propName"    # Ljava/lang/String;
    .param p2, "isMandatory"    # Z

    .line 101
    sget-object v0, Lcom/fasterxml/aalto/impl/CommonConfig;->sStdProperties:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    .line 102
    .local v0, "I":Ljava/lang/Integer;
    if-eqz v0, :cond_0

    .line 103
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v1

    packed-switch v1, :pswitch_data_0

    goto :goto_0

    .line 111
    :pswitch_0
    sget-object v1, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    return-object v1

    .line 109
    :pswitch_1
    sget-object v1, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    return-object v1

    .line 107
    :pswitch_2
    const-string v1, "0.9"

    return-object v1

    .line 105
    :pswitch_3
    const-string v1, "aalto"

    return-object v1

    .line 114
    :cond_0
    :goto_0
    if-nez p2, :cond_1

    .line 117
    const/4 v1, 0x0

    return-object v1

    .line 115
    :cond_1
    new-instance v1, Ljava/lang/IllegalArgumentException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unrecognized property \'"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\'"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method protected final hasExplicitFlag(I)Z
    .locals 1
    .param p1, "flagMask"    # I

    .line 181
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/impl/CommonConfig;->hasFlag(I)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/impl/CommonConfig;->hasFlagBeenModified(I)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method protected final hasFlag(I)Z
    .locals 1
    .param p1, "flagMask"    # I

    .line 176
    iget v0, p0, Lcom/fasterxml/aalto/impl/CommonConfig;->_flags:I

    and-int/2addr v0, p1

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method protected final hasFlagBeenModified(I)Z
    .locals 1
    .param p1, "flagMask"    # I

    .line 205
    iget v0, p0, Lcom/fasterxml/aalto/impl/CommonConfig;->_flagMods:I

    and-int/2addr v0, p1

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public isPropertySupported(Ljava/lang/String;)Z
    .locals 1
    .param p1, "propName"    # Ljava/lang/String;

    .line 122
    sget-object v0, Lcom/fasterxml/aalto/impl/CommonConfig;->sStdProperties:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public abstract isXml11()Z
.end method

.method protected final setFlag(IZ)V
    .locals 2
    .param p1, "flagMask"    # I
    .param p2, "state"    # Z

    .line 186
    if-eqz p2, :cond_0

    .line 187
    iget v0, p0, Lcom/fasterxml/aalto/impl/CommonConfig;->_flags:I

    or-int/2addr v0, p1

    iput v0, p0, Lcom/fasterxml/aalto/impl/CommonConfig;->_flags:I

    goto :goto_0

    .line 189
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/impl/CommonConfig;->_flags:I

    not-int v1, p1

    and-int/2addr v0, v1

    iput v0, p0, Lcom/fasterxml/aalto/impl/CommonConfig;->_flags:I

    .line 191
    :goto_0
    iget v0, p0, Lcom/fasterxml/aalto/impl/CommonConfig;->_flagMods:I

    or-int/2addr v0, p1

    iput v0, p0, Lcom/fasterxml/aalto/impl/CommonConfig;->_flagMods:I

    .line 192
    return-void
.end method

.method public setProperty(Ljava/lang/String;Ljava/lang/Object;)Z
    .locals 4
    .param p1, "propName"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Object;

    .line 131
    sget-object v0, Lcom/fasterxml/aalto/impl/CommonConfig;->sStdProperties:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    .line 132
    .local v0, "I":Ljava/lang/Integer;
    if-eqz v0, :cond_0

    .line 133
    const/4 v1, 0x0

    return v1

    .line 135
    :cond_0
    new-instance v1, Ljava/lang/IllegalArgumentException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unrecognized property \'"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\'"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1
.end method
