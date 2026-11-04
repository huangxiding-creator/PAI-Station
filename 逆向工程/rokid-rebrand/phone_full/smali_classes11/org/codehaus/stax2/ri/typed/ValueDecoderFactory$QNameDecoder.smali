.class public final Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;
.super Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecoderBase;
.source "ValueDecoderFactory.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "QNameDecoder"
.end annotation


# instance fields
.field final mNsCtxt:Ljavax/xml/namespace/NamespaceContext;

.field protected mValue:Ljavax/xml/namespace/QName;


# direct methods
.method public constructor <init>(Ljavax/xml/namespace/NamespaceContext;)V
    .locals 0
    .param p1, "nsc"    # Ljavax/xml/namespace/NamespaceContext;

    .line 1096
    invoke-direct {p0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecoderBase;-><init>()V

    .line 1097
    iput-object p1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;->mNsCtxt:Ljavax/xml/namespace/NamespaceContext;

    .line 1098
    return-void
.end method


# virtual methods
.method public decode(Ljava/lang/String;)V
    .locals 3
    .param p1, "lexical"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 1108
    const/16 v0, 0x3a

    invoke-virtual {p1, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    .line 1109
    .local v0, "ix":I
    if-ltz v0, :cond_0

    .line 1110
    const/4 v1, 0x0

    invoke-virtual {p1, v1, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    add-int/lit8 v2, v0, 0x1

    .line 1111
    invoke-virtual {p1, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v2

    .line 1110
    invoke-virtual {p0, v1, v2}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;->resolveQName(Ljava/lang/String;Ljava/lang/String;)Ljavax/xml/namespace/QName;

    move-result-object v1

    iput-object v1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;->mValue:Ljavax/xml/namespace/QName;

    goto :goto_0

    .line 1113
    :cond_0
    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;->resolveQName(Ljava/lang/String;)Ljavax/xml/namespace/QName;

    move-result-object v1

    iput-object v1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;->mValue:Ljavax/xml/namespace/QName;

    .line 1115
    :goto_0
    return-void
.end method

.method public decode([CII)V
    .locals 5
    .param p1, "lexical"    # [C
    .param p2, "start"    # I
    .param p3, "end"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 1120
    move v0, p2

    .line 1121
    .local v0, "i":I
    :goto_0
    if-ge v0, p3, :cond_1

    .line 1122
    aget-char v1, p1, v0

    const/16 v2, 0x3a

    if-ne v1, v2, :cond_0

    .line 1123
    new-instance v1, Ljava/lang/String;

    sub-int v2, v0, p2

    invoke-direct {v1, p1, p2, v2}, Ljava/lang/String;-><init>([CII)V

    new-instance v2, Ljava/lang/String;

    add-int/lit8 v3, v0, 0x1

    sub-int v4, p3, v0

    add-int/lit8 v4, v4, -0x1

    invoke-direct {v2, p1, v3, v4}, Ljava/lang/String;-><init>([CII)V

    invoke-virtual {p0, v1, v2}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;->resolveQName(Ljava/lang/String;Ljava/lang/String;)Ljavax/xml/namespace/QName;

    move-result-object v1

    iput-object v1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;->mValue:Ljavax/xml/namespace/QName;

    .line 1125
    return-void

    .line 1121
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1128
    :cond_1
    new-instance v1, Ljava/lang/String;

    sub-int v2, p3, p2

    invoke-direct {v1, p1, p2, v2}, Ljava/lang/String;-><init>([CII)V

    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;->resolveQName(Ljava/lang/String;)Ljavax/xml/namespace/QName;

    move-result-object v1

    iput-object v1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;->mValue:Ljavax/xml/namespace/QName;

    .line 1129
    return-void
.end method

.method public getType()Ljava/lang/String;
    .locals 1

    .line 1101
    const-string v0, "QName"

    return-object v0
.end method

.method public getValue()Ljavax/xml/namespace/QName;
    .locals 1

    .line 1103
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;->mValue:Ljavax/xml/namespace/QName;

    return-object v0
.end method

.method protected resolveQName(Ljava/lang/String;)Ljavax/xml/namespace/QName;
    .locals 2
    .param p1, "localName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 1134
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;->mNsCtxt:Ljavax/xml/namespace/NamespaceContext;

    const-string v1, ""

    invoke-interface {v0, v1}, Ljavax/xml/namespace/NamespaceContext;->getNamespaceURI(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1135
    .local v0, "uri":Ljava/lang/String;
    if-nez v0, :cond_0

    .line 1136
    const-string v0, ""

    .line 1138
    :cond_0
    new-instance v1, Ljavax/xml/namespace/QName;

    invoke-direct {v1, v0, p1}, Ljavax/xml/namespace/QName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    return-object v1
.end method

.method protected resolveQName(Ljava/lang/String;Ljava/lang/String;)Ljavax/xml/namespace/QName;
    .locals 5
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 1144
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    const-string v1, ":"

    if-eqz v0, :cond_1

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v0

    if-eqz v0, :cond_1

    .line 1152
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;->mNsCtxt:Ljavax/xml/namespace/NamespaceContext;

    invoke-interface {v0, p1}, Ljavax/xml/namespace/NamespaceContext;->getNamespaceURI(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1153
    .local v0, "uri":Ljava/lang/String;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_0

    .line 1156
    new-instance v1, Ljavax/xml/namespace/QName;

    invoke-direct {v1, v0, p2, p1}, Ljavax/xml/namespace/QName;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-object v1

    .line 1154
    :cond_0
    new-instance v2, Ljava/lang/IllegalArgumentException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Value \""

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;->lexicalDesc(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "\" not a valid QName: prefix \'"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "\' not bound to a namespace"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v2, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 1146
    .end local v0    # "uri":Ljava/lang/String;
    :cond_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;->constructInvalidValue(Ljava/lang/String;)Ljava/lang/IllegalArgumentException;

    move-result-object v0

    throw v0
.end method
