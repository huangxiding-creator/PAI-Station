.class public abstract Lcom/fasterxml/aalto/in/InputBootstrapper;
.super Ljava/lang/Object;
.source "InputBootstrapper.java"

# interfaces
.implements Lcom/fasterxml/aalto/util/XmlConsts;


# static fields
.field public static final ERR_XMLDECL_END_MARKER:Ljava/lang/String; = "; expected \"?>\" end marker"

.field public static final ERR_XMLDECL_EXP_ATTRVAL:Ljava/lang/String; = "; expected a quote character enclosing value for "

.field public static final ERR_XMLDECL_EXP_EQ:Ljava/lang/String; = "; expected \'=\' after "

.field public static final ERR_XMLDECL_EXP_SPACE:Ljava/lang/String; = "; expected a white space"

.field public static final ERR_XMLDECL_KW_ENCODING:Ljava/lang/String; = "; expected keyword \'encoding\'"

.field public static final ERR_XMLDECL_KW_STANDALONE:Ljava/lang/String; = "; expected keyword \'standalone\'"

.field public static final ERR_XMLDECL_KW_VERSION:Ljava/lang/String; = "; expected keyword \'version\'"


# instance fields
.field final _config:Lcom/fasterxml/aalto/in/ReaderConfig;

.field protected _inputProcessed:I

.field protected _inputRow:I

.field protected _inputRowStart:I

.field mDeclaredXmlVersion:I

.field mFoundEncoding:Ljava/lang/String;

.field final mKeyword:[C

.field mStandalone:Ljava/lang/String;


# direct methods
.method protected constructor <init>(Lcom/fasterxml/aalto/in/ReaderConfig;)V
    .locals 1
    .param p1, "cfg"    # Lcom/fasterxml/aalto/in/ReaderConfig;

    .line 128
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 62
    const/4 v0, 0x0

    iput v0, p0, Lcom/fasterxml/aalto/in/InputBootstrapper;->_inputProcessed:I

    .line 68
    iput v0, p0, Lcom/fasterxml/aalto/in/InputBootstrapper;->_inputRow:I

    .line 76
    iput v0, p0, Lcom/fasterxml/aalto/in/InputBootstrapper;->_inputRowStart:I

    .line 97
    iput v0, p0, Lcom/fasterxml/aalto/in/InputBootstrapper;->mDeclaredXmlVersion:I

    .line 129
    iput-object p1, p0, Lcom/fasterxml/aalto/in/InputBootstrapper;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    .line 130
    const/16 v0, 0x3c

    invoke-virtual {p1, v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->allocSmallCBuffer(I)[C

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/in/InputBootstrapper;->mKeyword:[C

    .line 131
    return-void
.end method

.method private final getWsOrChar(I)I
    .locals 3
    .param p1, "ok"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 311
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/InputBootstrapper;->getNext()I

    move-result v0

    .line 312
    .local v0, "c":I
    if-ne v0, p1, :cond_0

    .line 313
    return v0

    .line 315
    :cond_0
    const/16 v1, 0x20

    if-le v0, v1, :cond_1

    .line 316
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "; expected either \'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    int-to-char v2, p1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\' or white space"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/aalto/in/InputBootstrapper;->reportUnexpectedChar(ILjava/lang/String;)V

    .line 318
    :cond_1
    const/16 v1, 0xa

    if-eq v0, v1, :cond_2

    const/16 v1, 0xd

    if-ne v0, v1, :cond_3

    .line 320
    :cond_2
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/InputBootstrapper;->pushback()V

    .line 322
    :cond_3
    const/4 v1, 0x0

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/InputBootstrapper;->getNextAfterWs(Z)I

    move-result v1

    return v1
.end method

.method private final handleEq(Ljava/lang/String;)I
    .locals 5
    .param p1, "attr"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 291
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/InputBootstrapper;->getNextAfterWs(Z)I

    move-result v1

    .line 292
    .local v1, "c":I
    const/16 v2, 0x3d

    const-string v3, "\'"

    if-eq v1, v2, :cond_0

    .line 293
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "; expected \'=\' after \'"

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/aalto/in/InputBootstrapper;->reportUnexpectedChar(ILjava/lang/String;)V

    .line 296
    :cond_0
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/InputBootstrapper;->getNextAfterWs(Z)I

    move-result v0

    .line 297
    .end local v1    # "c":I
    .local v0, "c":I
    const/16 v1, 0x22

    if-eq v0, v1, :cond_1

    const/16 v1, 0x27

    if-eq v0, v1, :cond_1

    .line 298
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "; expected a quote character enclosing value for \'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/aalto/in/InputBootstrapper;->reportUnexpectedChar(ILjava/lang/String;)V

    .line 300
    :cond_1
    return v0
.end method

.method private final readXmlEncoding()Ljava/lang/String;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 229
    const-string v0, "encoding"

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/InputBootstrapper;->checkKeyword(Ljava/lang/String;)I

    move-result v1

    .line 230
    .local v1, "c":I
    if-eqz v1, :cond_0

    .line 231
    invoke-virtual {p0, v1, v0}, Lcom/fasterxml/aalto/in/InputBootstrapper;->reportUnexpectedChar(ILjava/lang/String;)V

    .line 233
    :cond_0
    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/in/InputBootstrapper;->handleEq(Ljava/lang/String;)I

    move-result v1

    .line 235
    iget-object v2, p0, Lcom/fasterxml/aalto/in/InputBootstrapper;->mKeyword:[C

    invoke-virtual {p0, v2, v1}, Lcom/fasterxml/aalto/in/InputBootstrapper;->readQuotedValue([CI)I

    move-result v2

    .line 240
    .local v2, "len":I
    if-nez v2, :cond_1

    .line 241
    const/4 v3, 0x0

    invoke-virtual {p0, v0, v3, v3, v3}, Lcom/fasterxml/aalto/in/InputBootstrapper;->reportPseudoAttrProblem(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 245
    :cond_1
    if-gez v2, :cond_2

    .line 246
    new-instance v0, Ljava/lang/String;

    iget-object v3, p0, Lcom/fasterxml/aalto/in/InputBootstrapper;->mKeyword:[C

    invoke-direct {v0, v3}, Ljava/lang/String;-><init>([C)V

    return-object v0

    .line 248
    :cond_2
    new-instance v0, Ljava/lang/String;

    iget-object v3, p0, Lcom/fasterxml/aalto/in/InputBootstrapper;->mKeyword:[C

    const/4 v4, 0x0

    invoke-direct {v0, v3, v4, v2}, Ljava/lang/String;-><init>([CII)V

    return-object v0
.end method

.method private final readXmlStandalone()Ljava/lang/String;
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 254
    const-string/jumbo v0, "standalone"

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/InputBootstrapper;->checkKeyword(Ljava/lang/String;)I

    move-result v1

    .line 255
    .local v1, "c":I
    if-eqz v1, :cond_0

    .line 256
    invoke-virtual {p0, v1, v0}, Lcom/fasterxml/aalto/in/InputBootstrapper;->reportUnexpectedChar(ILjava/lang/String;)V

    .line 258
    :cond_0
    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/in/InputBootstrapper;->handleEq(Ljava/lang/String;)I

    move-result v1

    .line 259
    iget-object v2, p0, Lcom/fasterxml/aalto/in/InputBootstrapper;->mKeyword:[C

    invoke-virtual {p0, v2, v1}, Lcom/fasterxml/aalto/in/InputBootstrapper;->readQuotedValue([CI)I

    move-result v2

    .line 261
    .local v2, "len":I
    const-string/jumbo v3, "yes"

    const-string v4, "no"

    const/4 v5, 0x1

    const/4 v6, 0x2

    const/4 v7, 0x0

    if-ne v2, v6, :cond_1

    .line 262
    iget-object v6, p0, Lcom/fasterxml/aalto/in/InputBootstrapper;->mKeyword:[C

    aget-char v6, v6, v7

    const/16 v8, 0x6e

    if-ne v6, v8, :cond_2

    iget-object v6, p0, Lcom/fasterxml/aalto/in/InputBootstrapper;->mKeyword:[C

    aget-char v5, v6, v5

    const/16 v6, 0x6f

    if-ne v5, v6, :cond_2

    .line 263
    return-object v4

    .line 265
    :cond_1
    const/4 v8, 0x3

    if-ne v2, v8, :cond_2

    .line 266
    iget-object v8, p0, Lcom/fasterxml/aalto/in/InputBootstrapper;->mKeyword:[C

    aget-char v8, v8, v7

    const/16 v9, 0x79

    if-ne v8, v9, :cond_2

    iget-object v8, p0, Lcom/fasterxml/aalto/in/InputBootstrapper;->mKeyword:[C

    aget-char v5, v8, v5

    const/16 v8, 0x65

    if-ne v5, v8, :cond_2

    iget-object v5, p0, Lcom/fasterxml/aalto/in/InputBootstrapper;->mKeyword:[C

    aget-char v5, v5, v6

    const/16 v6, 0x73

    if-ne v5, v6, :cond_2

    .line 268
    return-object v3

    .line 275
    :cond_2
    const-string v5, "\'"

    if-gez v2, :cond_3

    .line 276
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    new-instance v6, Ljava/lang/String;

    iget-object v7, p0, Lcom/fasterxml/aalto/in/InputBootstrapper;->mKeyword:[C

    invoke-direct {v6, v7}, Ljava/lang/String;-><init>([C)V

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "[..]\'"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .local v5, "got":Ljava/lang/String;
    goto :goto_0

    .line 277
    .end local v5    # "got":Ljava/lang/String;
    :cond_3
    if-nez v2, :cond_4

    .line 278
    const-string v5, "<empty>"

    .restart local v5    # "got":Ljava/lang/String;
    goto :goto_0

    .line 280
    .end local v5    # "got":Ljava/lang/String;
    :cond_4
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    new-instance v8, Ljava/lang/String;

    iget-object v9, p0, Lcom/fasterxml/aalto/in/InputBootstrapper;->mKeyword:[C

    invoke-direct {v8, v9, v7, v2}, Ljava/lang/String;-><init>([CII)V

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 283
    .restart local v5    # "got":Ljava/lang/String;
    :goto_0
    invoke-virtual {p0, v0, v5, v3, v4}, Lcom/fasterxml/aalto/in/InputBootstrapper;->reportPseudoAttrProblem(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 285
    return-object v5
.end method

.method private final readXmlVersion()I
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 192
    const-string/jumbo v0, "version"

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/InputBootstrapper;->checkKeyword(Ljava/lang/String;)I

    move-result v1

    .line 193
    .local v1, "c":I
    if-eqz v1, :cond_0

    .line 194
    invoke-virtual {p0, v1, v0}, Lcom/fasterxml/aalto/in/InputBootstrapper;->reportUnexpectedChar(ILjava/lang/String;)V

    .line 196
    :cond_0
    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/in/InputBootstrapper;->handleEq(Ljava/lang/String;)I

    move-result v1

    .line 197
    iget-object v2, p0, Lcom/fasterxml/aalto/in/InputBootstrapper;->mKeyword:[C

    invoke-virtual {p0, v2, v1}, Lcom/fasterxml/aalto/in/InputBootstrapper;->readQuotedValue([CI)I

    move-result v2

    .line 199
    .local v2, "len":I
    const/4 v3, 0x3

    const/4 v4, 0x0

    if-ne v2, v3, :cond_2

    .line 200
    iget-object v3, p0, Lcom/fasterxml/aalto/in/InputBootstrapper;->mKeyword:[C

    aget-char v3, v3, v4

    const/16 v5, 0x31

    if-ne v3, v5, :cond_2

    iget-object v3, p0, Lcom/fasterxml/aalto/in/InputBootstrapper;->mKeyword:[C

    const/4 v6, 0x1

    aget-char v3, v3, v6

    const/16 v6, 0x2e

    if-ne v3, v6, :cond_2

    .line 201
    iget-object v3, p0, Lcom/fasterxml/aalto/in/InputBootstrapper;->mKeyword:[C

    const/4 v6, 0x2

    aget-char v1, v3, v6

    .line 202
    const/16 v3, 0x30

    if-ne v1, v3, :cond_1

    .line 203
    const/16 v0, 0x100

    return v0

    .line 205
    :cond_1
    if-ne v1, v5, :cond_2

    .line 206
    const/16 v0, 0x110

    return v0

    .line 214
    :cond_2
    const-string v3, "\'"

    if-gez v2, :cond_3

    .line 215
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    new-instance v5, Ljava/lang/String;

    iget-object v6, p0, Lcom/fasterxml/aalto/in/InputBootstrapper;->mKeyword:[C

    invoke-direct {v5, v6}, Ljava/lang/String;-><init>([C)V

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v5, "[..]\'"

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .local v3, "got":Ljava/lang/String;
    goto :goto_0

    .line 216
    .end local v3    # "got":Ljava/lang/String;
    :cond_3
    if-nez v2, :cond_4

    .line 217
    const-string v3, "<empty>"

    .restart local v3    # "got":Ljava/lang/String;
    goto :goto_0

    .line 219
    .end local v3    # "got":Ljava/lang/String;
    :cond_4
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    new-instance v6, Ljava/lang/String;

    iget-object v7, p0, Lcom/fasterxml/aalto/in/InputBootstrapper;->mKeyword:[C

    invoke-direct {v6, v7, v4, v2}, Ljava/lang/String;-><init>([CII)V

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 221
    .restart local v3    # "got":Ljava/lang/String;
    :goto_0
    const-string v5, "1.0"

    const-string v6, "1.1"

    invoke-virtual {p0, v0, v3, v5, v6}, Lcom/fasterxml/aalto/in/InputBootstrapper;->reportPseudoAttrProblem(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 223
    return v4
.end method


# virtual methods
.method public abstract bootstrap()Lcom/fasterxml/aalto/in/XmlScanner;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected abstract checkKeyword(Ljava/lang/String;)I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected abstract getLocation()Ljavax/xml/stream/Location;
.end method

.method protected abstract getNext()I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected abstract getNextAfterWs(Z)I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected abstract pushback()V
.end method

.method protected abstract readQuotedValue([CI)I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected readXmlDeclaration()V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 152
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/InputBootstrapper;->getNextAfterWs(Z)I

    move-result v0

    .line 156
    .local v0, "c":I
    const/16 v1, 0x76

    const/16 v2, 0x3f

    if-eq v0, v1, :cond_0

    .line 157
    const-string v1, "; expected keyword \'version\'"

    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/aalto/in/InputBootstrapper;->reportUnexpectedChar(ILjava/lang/String;)V

    goto :goto_0

    .line 159
    :cond_0
    invoke-direct {p0}, Lcom/fasterxml/aalto/in/InputBootstrapper;->readXmlVersion()I

    move-result v1

    iput v1, p0, Lcom/fasterxml/aalto/in/InputBootstrapper;->mDeclaredXmlVersion:I

    .line 160
    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/in/InputBootstrapper;->getWsOrChar(I)I

    move-result v0

    .line 164
    :goto_0
    const/16 v1, 0x65

    if-ne v0, v1, :cond_1

    .line 165
    invoke-direct {p0}, Lcom/fasterxml/aalto/in/InputBootstrapper;->readXmlEncoding()Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/fasterxml/aalto/in/InputBootstrapper;->mFoundEncoding:Ljava/lang/String;

    .line 166
    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/in/InputBootstrapper;->getWsOrChar(I)I

    move-result v0

    .line 170
    :cond_1
    const/16 v1, 0x73

    if-ne v0, v1, :cond_2

    .line 171
    invoke-direct {p0}, Lcom/fasterxml/aalto/in/InputBootstrapper;->readXmlStandalone()Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/fasterxml/aalto/in/InputBootstrapper;->mStandalone:Ljava/lang/String;

    .line 172
    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/in/InputBootstrapper;->getWsOrChar(I)I

    move-result v0

    .line 177
    :cond_2
    const-string v1, "; expected \"?>\" end marker"

    if-eq v0, v2, :cond_3

    .line 178
    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/aalto/in/InputBootstrapper;->reportUnexpectedChar(ILjava/lang/String;)V

    .line 180
    :cond_3
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/InputBootstrapper;->getNext()I

    move-result v0

    .line 181
    const/16 v2, 0x3e

    if-eq v0, v2, :cond_4

    .line 182
    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/aalto/in/InputBootstrapper;->reportUnexpectedChar(ILjava/lang/String;)V

    .line 184
    :cond_4
    return-void
.end method

.method protected reportEof()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 372
    const-string v0, "Unexpected end-of-input in xml declaration"

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/InputBootstrapper;->reportXmlProblem(Ljava/lang/String;)V

    .line 373
    return-void
.end method

.method protected reportNull()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 366
    const-string v0, "Illegal null byte/char in input stream"

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/InputBootstrapper;->reportXmlProblem(Ljava/lang/String;)V

    .line 367
    return-void
.end method

.method protected final reportPseudoAttrProblem(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 3
    .param p1, "attrName"    # Ljava/lang/String;
    .param p2, "got"    # Ljava/lang/String;
    .param p3, "expVal1"    # Ljava/lang/String;
    .param p4, "expVal2"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 392
    if-nez p3, :cond_0

    const-string v0, ""

    goto :goto_0

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "; expected \""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\" or \""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 395
    .local v0, "expStr":Ljava/lang/String;
    :goto_0
    if-eqz p2, :cond_1

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_2

    .line 396
    :cond_1
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Missing XML pseudo-attribute \'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\' value"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/InputBootstrapper;->reportXmlProblem(Ljava/lang/String;)V

    .line 398
    :cond_2
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Invalid XML pseudo-attribute \'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\' value "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/InputBootstrapper;->reportXmlProblem(Ljava/lang/String;)V

    .line 399
    return-void
.end method

.method protected reportUnexpectedChar(ILjava/lang/String;)V
    .locals 3
    .param p1, "i"    # I
    .param p2, "msg"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 380
    int-to-char v0, p1

    invoke-static {v0}, Ljava/lang/Character;->isISOControl(C)Z

    move-result v0

    const-string v1, ")"

    if-eqz v0, :cond_0

    .line 381
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unexpected character (CTRL-CHAR, code "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .local v0, "excMsg":Ljava/lang/String;
    goto :goto_0

    .line 383
    .end local v0    # "excMsg":Ljava/lang/String;
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unexpected character \'"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    int-to-char v2, p1

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "\' (code "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 385
    .restart local v0    # "excMsg":Ljava/lang/String;
    :goto_0
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/InputBootstrapper;->reportXmlProblem(Ljava/lang/String;)V

    .line 386
    return-void
.end method

.method protected reportXmlProblem(Ljava/lang/String;)V
    .locals 2
    .param p1, "msg"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 360
    new-instance v0, Lcom/fasterxml/aalto/WFCException;

    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/InputBootstrapper;->getLocation()Ljavax/xml/stream/Location;

    move-result-object v1

    invoke-direct {v0, p1, v1}, Lcom/fasterxml/aalto/WFCException;-><init>(Ljava/lang/String;Ljavax/xml/stream/Location;)V

    throw v0
.end method
