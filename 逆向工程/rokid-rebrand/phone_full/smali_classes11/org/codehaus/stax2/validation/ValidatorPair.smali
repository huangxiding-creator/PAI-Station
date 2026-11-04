.class public Lorg/codehaus/stax2/validation/ValidatorPair;
.super Lorg/codehaus/stax2/validation/XMLValidator;
.source "ValidatorPair.java"


# static fields
.field public static final ATTR_TYPE_DEFAULT:Ljava/lang/String; = "CDATA"


# instance fields
.field protected mFirst:Lorg/codehaus/stax2/validation/XMLValidator;

.field protected mSecond:Lorg/codehaus/stax2/validation/XMLValidator;


# direct methods
.method public constructor <init>(Lorg/codehaus/stax2/validation/XMLValidator;Lorg/codehaus/stax2/validation/XMLValidator;)V
    .locals 0
    .param p1, "first"    # Lorg/codehaus/stax2/validation/XMLValidator;
    .param p2, "second"    # Lorg/codehaus/stax2/validation/XMLValidator;

    .line 32
    invoke-direct {p0}, Lorg/codehaus/stax2/validation/XMLValidator;-><init>()V

    .line 33
    iput-object p1, p0, Lorg/codehaus/stax2/validation/ValidatorPair;->mFirst:Lorg/codehaus/stax2/validation/XMLValidator;

    .line 34
    iput-object p2, p0, Lorg/codehaus/stax2/validation/ValidatorPair;->mSecond:Lorg/codehaus/stax2/validation/XMLValidator;

    .line 35
    return-void
.end method

.method private doRemoveValidator(Lorg/codehaus/stax2/validation/XMLValidationSchema;[Lorg/codehaus/stax2/validation/XMLValidator;)Z
    .locals 3
    .param p1, "schema"    # Lorg/codehaus/stax2/validation/XMLValidationSchema;
    .param p2, "results"    # [Lorg/codehaus/stax2/validation/XMLValidator;

    .line 222
    iget-object v0, p0, Lorg/codehaus/stax2/validation/ValidatorPair;->mFirst:Lorg/codehaus/stax2/validation/XMLValidator;

    invoke-static {v0, p1, p2}, Lorg/codehaus/stax2/validation/ValidatorPair;->removeValidator(Lorg/codehaus/stax2/validation/XMLValidator;Lorg/codehaus/stax2/validation/XMLValidationSchema;[Lorg/codehaus/stax2/validation/XMLValidator;)Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_1

    .line 223
    aget-object v0, p2, v1

    .line 224
    .local v0, "newFirst":Lorg/codehaus/stax2/validation/XMLValidator;
    if-nez v0, :cond_0

    .line 225
    iget-object v2, p0, Lorg/codehaus/stax2/validation/ValidatorPair;->mSecond:Lorg/codehaus/stax2/validation/XMLValidator;

    aput-object v2, p2, v1

    goto :goto_0

    .line 227
    :cond_0
    iput-object v0, p0, Lorg/codehaus/stax2/validation/ValidatorPair;->mFirst:Lorg/codehaus/stax2/validation/XMLValidator;

    .line 228
    aput-object p0, p2, v1

    .line 230
    :goto_0
    return v1

    .line 232
    .end local v0    # "newFirst":Lorg/codehaus/stax2/validation/XMLValidator;
    :cond_1
    iget-object v0, p0, Lorg/codehaus/stax2/validation/ValidatorPair;->mSecond:Lorg/codehaus/stax2/validation/XMLValidator;

    invoke-static {v0, p1, p2}, Lorg/codehaus/stax2/validation/ValidatorPair;->removeValidator(Lorg/codehaus/stax2/validation/XMLValidator;Lorg/codehaus/stax2/validation/XMLValidationSchema;[Lorg/codehaus/stax2/validation/XMLValidator;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 233
    aget-object v0, p2, v1

    .line 234
    .local v0, "newSecond":Lorg/codehaus/stax2/validation/XMLValidator;
    if-nez v0, :cond_2

    .line 235
    iget-object v2, p0, Lorg/codehaus/stax2/validation/ValidatorPair;->mFirst:Lorg/codehaus/stax2/validation/XMLValidator;

    aput-object v2, p2, v1

    goto :goto_1

    .line 237
    :cond_2
    iput-object v0, p0, Lorg/codehaus/stax2/validation/ValidatorPair;->mSecond:Lorg/codehaus/stax2/validation/XMLValidator;

    .line 238
    aput-object p0, p2, v1

    .line 240
    :goto_1
    return v1

    .line 242
    .end local v0    # "newSecond":Lorg/codehaus/stax2/validation/XMLValidator;
    :cond_3
    const/4 v0, 0x0

    return v0
.end method

.method private doRemoveValidator(Lorg/codehaus/stax2/validation/XMLValidator;[Lorg/codehaus/stax2/validation/XMLValidator;)Z
    .locals 3
    .param p1, "vld"    # Lorg/codehaus/stax2/validation/XMLValidator;
    .param p2, "results"    # [Lorg/codehaus/stax2/validation/XMLValidator;

    .line 247
    iget-object v0, p0, Lorg/codehaus/stax2/validation/ValidatorPair;->mFirst:Lorg/codehaus/stax2/validation/XMLValidator;

    invoke-static {v0, p1, p2}, Lorg/codehaus/stax2/validation/ValidatorPair;->removeValidator(Lorg/codehaus/stax2/validation/XMLValidator;Lorg/codehaus/stax2/validation/XMLValidator;[Lorg/codehaus/stax2/validation/XMLValidator;)Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_1

    .line 248
    aget-object v0, p2, v1

    .line 249
    .local v0, "newFirst":Lorg/codehaus/stax2/validation/XMLValidator;
    if-nez v0, :cond_0

    .line 250
    iget-object v2, p0, Lorg/codehaus/stax2/validation/ValidatorPair;->mSecond:Lorg/codehaus/stax2/validation/XMLValidator;

    aput-object v2, p2, v1

    goto :goto_0

    .line 252
    :cond_0
    iput-object v0, p0, Lorg/codehaus/stax2/validation/ValidatorPair;->mFirst:Lorg/codehaus/stax2/validation/XMLValidator;

    .line 253
    aput-object p0, p2, v1

    .line 255
    :goto_0
    return v1

    .line 257
    .end local v0    # "newFirst":Lorg/codehaus/stax2/validation/XMLValidator;
    :cond_1
    iget-object v0, p0, Lorg/codehaus/stax2/validation/ValidatorPair;->mSecond:Lorg/codehaus/stax2/validation/XMLValidator;

    invoke-static {v0, p1, p2}, Lorg/codehaus/stax2/validation/ValidatorPair;->removeValidator(Lorg/codehaus/stax2/validation/XMLValidator;Lorg/codehaus/stax2/validation/XMLValidator;[Lorg/codehaus/stax2/validation/XMLValidator;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 258
    aget-object v0, p2, v1

    .line 259
    .local v0, "newSecond":Lorg/codehaus/stax2/validation/XMLValidator;
    if-nez v0, :cond_2

    .line 260
    iget-object v2, p0, Lorg/codehaus/stax2/validation/ValidatorPair;->mFirst:Lorg/codehaus/stax2/validation/XMLValidator;

    aput-object v2, p2, v1

    goto :goto_1

    .line 262
    :cond_2
    iput-object v0, p0, Lorg/codehaus/stax2/validation/ValidatorPair;->mSecond:Lorg/codehaus/stax2/validation/XMLValidator;

    .line 263
    aput-object p0, p2, v1

    .line 265
    :goto_1
    return v1

    .line 267
    .end local v0    # "newSecond":Lorg/codehaus/stax2/validation/XMLValidator;
    :cond_3
    const/4 v0, 0x0

    return v0
.end method

.method public static removeValidator(Lorg/codehaus/stax2/validation/XMLValidator;Lorg/codehaus/stax2/validation/XMLValidationSchema;[Lorg/codehaus/stax2/validation/XMLValidator;)Z
    .locals 2
    .param p0, "root"    # Lorg/codehaus/stax2/validation/XMLValidator;
    .param p1, "schema"    # Lorg/codehaus/stax2/validation/XMLValidationSchema;
    .param p2, "results"    # [Lorg/codehaus/stax2/validation/XMLValidator;

    .line 196
    instance-of v0, p0, Lorg/codehaus/stax2/validation/ValidatorPair;

    if-eqz v0, :cond_0

    .line 197
    move-object v0, p0

    check-cast v0, Lorg/codehaus/stax2/validation/ValidatorPair;

    invoke-direct {v0, p1, p2}, Lorg/codehaus/stax2/validation/ValidatorPair;->doRemoveValidator(Lorg/codehaus/stax2/validation/XMLValidationSchema;[Lorg/codehaus/stax2/validation/XMLValidator;)Z

    move-result v0

    return v0

    .line 199
    :cond_0
    invoke-virtual {p0}, Lorg/codehaus/stax2/validation/XMLValidator;->getSchema()Lorg/codehaus/stax2/validation/XMLValidationSchema;

    move-result-object v0

    const/4 v1, 0x0

    if-ne v0, p1, :cond_1

    .line 200
    aput-object p0, p2, v1

    .line 201
    const/4 v0, 0x0

    const/4 v1, 0x1

    aput-object v0, p2, v1

    .line 202
    return v1

    .line 205
    :cond_1
    return v1
.end method

.method public static removeValidator(Lorg/codehaus/stax2/validation/XMLValidator;Lorg/codehaus/stax2/validation/XMLValidator;[Lorg/codehaus/stax2/validation/XMLValidator;)Z
    .locals 2
    .param p0, "root"    # Lorg/codehaus/stax2/validation/XMLValidator;
    .param p1, "vld"    # Lorg/codehaus/stax2/validation/XMLValidator;
    .param p2, "results"    # [Lorg/codehaus/stax2/validation/XMLValidator;

    .line 210
    const/4 v0, 0x0

    if-ne p0, p1, :cond_0

    .line 211
    aput-object p0, p2, v0

    .line 212
    const/4 v0, 0x0

    const/4 v1, 0x1

    aput-object v0, p2, v1

    .line 213
    return v1

    .line 214
    :cond_0
    instance-of v1, p0, Lorg/codehaus/stax2/validation/ValidatorPair;

    if-eqz v1, :cond_1

    .line 215
    move-object v0, p0

    check-cast v0, Lorg/codehaus/stax2/validation/ValidatorPair;

    invoke-direct {v0, p1, p2}, Lorg/codehaus/stax2/validation/ValidatorPair;->doRemoveValidator(Lorg/codehaus/stax2/validation/XMLValidator;[Lorg/codehaus/stax2/validation/XMLValidator;)Z

    move-result v0

    return v0

    .line 217
    :cond_1
    return v0
.end method


# virtual methods
.method public getAttributeType(I)Ljava/lang/String;
    .locals 3
    .param p1, "index"    # I

    .line 153
    iget-object v0, p0, Lorg/codehaus/stax2/validation/ValidatorPair;->mFirst:Lorg/codehaus/stax2/validation/XMLValidator;

    invoke-virtual {v0, p1}, Lorg/codehaus/stax2/validation/XMLValidator;->getAttributeType(I)Ljava/lang/String;

    move-result-object v0

    .line 158
    .local v0, "type":Ljava/lang/String;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-eqz v1, :cond_0

    const-string v1, "CDATA"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 159
    :cond_0
    iget-object v1, p0, Lorg/codehaus/stax2/validation/ValidatorPair;->mSecond:Lorg/codehaus/stax2/validation/XMLValidator;

    invoke-virtual {v1, p1}, Lorg/codehaus/stax2/validation/XMLValidator;->getAttributeType(I)Ljava/lang/String;

    move-result-object v1

    .line 160
    .local v1, "type2":Ljava/lang/String;
    if-eqz v1, :cond_1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-lez v2, :cond_1

    .line 161
    return-object v1

    .line 165
    .end local v1    # "type2":Ljava/lang/String;
    :cond_1
    return-object v0
.end method

.method public getIdAttrIndex()I
    .locals 2

    .line 171
    iget-object v0, p0, Lorg/codehaus/stax2/validation/ValidatorPair;->mFirst:Lorg/codehaus/stax2/validation/XMLValidator;

    invoke-virtual {v0}, Lorg/codehaus/stax2/validation/XMLValidator;->getIdAttrIndex()I

    move-result v0

    .line 172
    .local v0, "index":I
    if-gez v0, :cond_0

    .line 173
    iget-object v1, p0, Lorg/codehaus/stax2/validation/ValidatorPair;->mSecond:Lorg/codehaus/stax2/validation/XMLValidator;

    invoke-virtual {v1}, Lorg/codehaus/stax2/validation/XMLValidator;->getIdAttrIndex()I

    move-result v1

    return v1

    .line 175
    :cond_0
    return v0
.end method

.method public getNotationAttrIndex()I
    .locals 2

    .line 181
    iget-object v0, p0, Lorg/codehaus/stax2/validation/ValidatorPair;->mFirst:Lorg/codehaus/stax2/validation/XMLValidator;

    invoke-virtual {v0}, Lorg/codehaus/stax2/validation/XMLValidator;->getNotationAttrIndex()I

    move-result v0

    .line 182
    .local v0, "index":I
    if-gez v0, :cond_0

    .line 183
    iget-object v1, p0, Lorg/codehaus/stax2/validation/ValidatorPair;->mSecond:Lorg/codehaus/stax2/validation/XMLValidator;

    invoke-virtual {v1}, Lorg/codehaus/stax2/validation/XMLValidator;->getNotationAttrIndex()I

    move-result v1

    return v1

    .line 185
    :cond_0
    return v0
.end method

.method public getSchema()Lorg/codehaus/stax2/validation/XMLValidationSchema;
    .locals 1

    .line 49
    const/4 v0, 0x0

    return-object v0
.end method

.method public validateAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "localName"    # Ljava/lang/String;
    .param p2, "uri"    # Ljava/lang/String;
    .param p3, "prefix"    # Ljava/lang/String;
    .param p4, "value"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 66
    iget-object v0, p0, Lorg/codehaus/stax2/validation/ValidatorPair;->mFirst:Lorg/codehaus/stax2/validation/XMLValidator;

    invoke-virtual {v0, p1, p2, p3, p4}, Lorg/codehaus/stax2/validation/XMLValidator;->validateAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 68
    .local v0, "retVal":Ljava/lang/String;
    if-eqz v0, :cond_0

    .line 69
    move-object p4, v0

    .line 71
    :cond_0
    iget-object v1, p0, Lorg/codehaus/stax2/validation/ValidatorPair;->mSecond:Lorg/codehaus/stax2/validation/XMLValidator;

    invoke-virtual {v1, p1, p2, p3, p4}, Lorg/codehaus/stax2/validation/XMLValidator;->validateAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public validateAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[CII)Ljava/lang/String;
    .locals 9
    .param p1, "localName"    # Ljava/lang/String;
    .param p2, "uri"    # Ljava/lang/String;
    .param p3, "prefix"    # Ljava/lang/String;
    .param p4, "valueChars"    # [C
    .param p5, "valueStart"    # I
    .param p6, "valueEnd"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 81
    iget-object v0, p0, Lorg/codehaus/stax2/validation/ValidatorPair;->mFirst:Lorg/codehaus/stax2/validation/XMLValidator;

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move v5, p5

    move v6, p6

    invoke-virtual/range {v0 .. v6}, Lorg/codehaus/stax2/validation/XMLValidator;->validateAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[CII)Ljava/lang/String;

    move-result-object v0

    .line 86
    .local v0, "retVal":Ljava/lang/String;
    if-eqz v0, :cond_0

    .line 87
    iget-object v1, p0, Lorg/codehaus/stax2/validation/ValidatorPair;->mSecond:Lorg/codehaus/stax2/validation/XMLValidator;

    invoke-virtual {v1, p1, p2, p3, v0}, Lorg/codehaus/stax2/validation/XMLValidator;->validateAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 90
    :cond_0
    iget-object v2, p0, Lorg/codehaus/stax2/validation/ValidatorPair;->mSecond:Lorg/codehaus/stax2/validation/XMLValidator;

    move-object v3, p1

    move-object v4, p2

    move-object v5, p3

    move-object v6, p4

    move v7, p5

    move v8, p6

    invoke-virtual/range {v2 .. v8}, Lorg/codehaus/stax2/validation/XMLValidator;->validateAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[CII)Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public validateElementAndAttributes()I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 98
    iget-object v0, p0, Lorg/codehaus/stax2/validation/ValidatorPair;->mFirst:Lorg/codehaus/stax2/validation/XMLValidator;

    invoke-virtual {v0}, Lorg/codehaus/stax2/validation/XMLValidator;->validateElementAndAttributes()I

    move-result v0

    .line 99
    .local v0, "textType1":I
    iget-object v1, p0, Lorg/codehaus/stax2/validation/ValidatorPair;->mSecond:Lorg/codehaus/stax2/validation/XMLValidator;

    invoke-virtual {v1}, Lorg/codehaus/stax2/validation/XMLValidator;->validateElementAndAttributes()I

    move-result v1

    .line 105
    .local v1, "textType2":I
    if-ge v0, v1, :cond_0

    move v2, v0

    goto :goto_0

    :cond_0
    move v2, v1

    :goto_0
    return v2
.end method

.method public validateElementEnd(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I
    .locals 3
    .param p1, "localName"    # Ljava/lang/String;
    .param p2, "uri"    # Ljava/lang/String;
    .param p3, "prefix"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 112
    iget-object v0, p0, Lorg/codehaus/stax2/validation/ValidatorPair;->mFirst:Lorg/codehaus/stax2/validation/XMLValidator;

    invoke-virtual {v0, p1, p2, p3}, Lorg/codehaus/stax2/validation/XMLValidator;->validateElementEnd(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 113
    .local v0, "textType1":I
    iget-object v1, p0, Lorg/codehaus/stax2/validation/ValidatorPair;->mSecond:Lorg/codehaus/stax2/validation/XMLValidator;

    invoke-virtual {v1, p1, p2, p3}, Lorg/codehaus/stax2/validation/XMLValidator;->validateElementEnd(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 116
    .local v1, "textType2":I
    if-ge v0, v1, :cond_0

    move v2, v0

    goto :goto_0

    :cond_0
    move v2, v1

    :goto_0
    return v2
.end method

.method public validateElementStart(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "localName"    # Ljava/lang/String;
    .param p2, "uri"    # Ljava/lang/String;
    .param p3, "prefix"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 57
    iget-object v0, p0, Lorg/codehaus/stax2/validation/ValidatorPair;->mFirst:Lorg/codehaus/stax2/validation/XMLValidator;

    invoke-virtual {v0, p1, p2, p3}, Lorg/codehaus/stax2/validation/XMLValidator;->validateElementStart(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 58
    iget-object v0, p0, Lorg/codehaus/stax2/validation/ValidatorPair;->mSecond:Lorg/codehaus/stax2/validation/XMLValidator;

    invoke-virtual {v0, p1, p2, p3}, Lorg/codehaus/stax2/validation/XMLValidator;->validateElementStart(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 59
    return-void
.end method

.method public validateText(Ljava/lang/String;Z)V
    .locals 1
    .param p1, "text"    # Ljava/lang/String;
    .param p2, "lastTextSegment"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 123
    iget-object v0, p0, Lorg/codehaus/stax2/validation/ValidatorPair;->mFirst:Lorg/codehaus/stax2/validation/XMLValidator;

    invoke-virtual {v0, p1, p2}, Lorg/codehaus/stax2/validation/XMLValidator;->validateText(Ljava/lang/String;Z)V

    .line 124
    iget-object v0, p0, Lorg/codehaus/stax2/validation/ValidatorPair;->mSecond:Lorg/codehaus/stax2/validation/XMLValidator;

    invoke-virtual {v0, p1, p2}, Lorg/codehaus/stax2/validation/XMLValidator;->validateText(Ljava/lang/String;Z)V

    .line 125
    return-void
.end method

.method public validateText([CIIZ)V
    .locals 1
    .param p1, "cbuf"    # [C
    .param p2, "textStart"    # I
    .param p3, "textEnd"    # I
    .param p4, "lastTextSegment"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 132
    iget-object v0, p0, Lorg/codehaus/stax2/validation/ValidatorPair;->mFirst:Lorg/codehaus/stax2/validation/XMLValidator;

    invoke-virtual {v0, p1, p2, p3, p4}, Lorg/codehaus/stax2/validation/XMLValidator;->validateText([CIIZ)V

    .line 133
    iget-object v0, p0, Lorg/codehaus/stax2/validation/ValidatorPair;->mSecond:Lorg/codehaus/stax2/validation/XMLValidator;

    invoke-virtual {v0, p1, p2, p3, p4}, Lorg/codehaus/stax2/validation/XMLValidator;->validateText([CIIZ)V

    .line 134
    return-void
.end method

.method public validationCompleted(Z)V
    .locals 1
    .param p1, "eod"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 140
    iget-object v0, p0, Lorg/codehaus/stax2/validation/ValidatorPair;->mFirst:Lorg/codehaus/stax2/validation/XMLValidator;

    invoke-virtual {v0, p1}, Lorg/codehaus/stax2/validation/XMLValidator;->validationCompleted(Z)V

    .line 141
    iget-object v0, p0, Lorg/codehaus/stax2/validation/ValidatorPair;->mSecond:Lorg/codehaus/stax2/validation/XMLValidator;

    invoke-virtual {v0, p1}, Lorg/codehaus/stax2/validation/XMLValidator;->validationCompleted(Z)V

    .line 142
    return-void
.end method
