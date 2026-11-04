.class public abstract Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;
.super Ljava/lang/Object;
.source "DOMWrappingReader.java"

# interfaces
.implements Lorg/codehaus/stax2/XMLStreamReader2;
.implements Lorg/codehaus/stax2/AttributeInfo;
.implements Lorg/codehaus/stax2/DTDInfo;
.implements Lorg/codehaus/stax2/LocationInfo;
.implements Ljavax/xml/namespace/NamespaceContext;
.implements Ljavax/xml/stream/XMLStreamConstants;


# static fields
.field protected static final ERR_STATE_NOT_ELEM:I = 0x2

.field protected static final ERR_STATE_NOT_PI:I = 0x3

.field protected static final ERR_STATE_NOT_START_ELEM:I = 0x1

.field protected static final ERR_STATE_NOT_TEXTUAL:I = 0x4

.field protected static final ERR_STATE_NOT_TEXTUAL_OR_ELEM:I = 0x6

.field protected static final ERR_STATE_NOT_TEXTUAL_XXX:I = 0x5

.field protected static final ERR_STATE_NO_LOCALNAME:I = 0x7

.field protected static final INT_SPACE:I = 0x20

.field private static final MASK_GET_ELEMENT_TEXT:I = 0x1250

.field private static final MASK_GET_TEXT:I = 0x1a70

.field private static final MASK_GET_TEXT_XXX:I = 0x1070

.field protected static final MASK_TYPED_ACCESS_BINARY:I = 0x1052


# instance fields
.field protected _attrList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lorg/w3c/dom/Node;",
            ">;"
        }
    .end annotation
.end field

.field protected _base64Decoder:Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;

.field protected _cfgInternNames:Z

.field protected _cfgInternNsURIs:Z

.field protected final _cfgNsAware:Z

.field protected _coalescedText:Ljava/lang/String;

.field protected final _coalescing:Z

.field protected _currEvent:I

.field protected _currNode:Lorg/w3c/dom/Node;

.field protected _decoderFactory:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

.field protected _depth:I

.field protected _nsDeclList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field protected final _rootNode:Lorg/w3c/dom/Node;

.field protected final _systemId:Ljava/lang/String;

.field protected _textBuffer:Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;


# direct methods
.method protected constructor <init>(Ljavax/xml/transform/dom/DOMSource;ZZ)V
    .locals 4
    .param p1, "src"    # Ljavax/xml/transform/dom/DOMSource;
    .param p2, "nsAware"    # Z
    .param p3, "coalescing"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 243
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 157
    const/4 v0, 0x0

    iput-boolean v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_cfgInternNames:Z

    .line 163
    iput-boolean v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_cfgInternNsURIs:Z

    .line 167
    const/4 v1, 0x7

    iput v1, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    .line 175
    iput v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_depth:I

    .line 188
    new-instance v0, Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;

    invoke-direct {v0}, Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;-><init>()V

    iput-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_textBuffer:Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;

    .line 204
    const/4 v0, 0x0

    iput-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_attrList:Ljava/util/List;

    .line 213
    iput-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_nsDeclList:Ljava/util/List;

    .line 224
    iput-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_base64Decoder:Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;

    .line 244
    invoke-virtual {p1}, Ljavax/xml/transform/dom/DOMSource;->getNode()Lorg/w3c/dom/Node;

    move-result-object v0

    .line 245
    .local v0, "treeRoot":Lorg/w3c/dom/Node;
    if-eqz v0, :cond_0

    .line 248
    iput-boolean p2, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_cfgNsAware:Z

    .line 249
    iput-boolean p3, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_coalescing:Z

    .line 250
    invoke-virtual {p1}, Ljavax/xml/transform/dom/DOMSource;->getSystemId()Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_systemId:Ljava/lang/String;

    .line 255
    invoke-interface {v0}, Lorg/w3c/dom/Node;->getNodeType()S

    move-result v1

    sparse-switch v1, :sswitch_data_0

    .line 269
    new-instance v1, Ljavax/xml/stream/XMLStreamException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Can not create an XMLStreamReader for a DOM node of type "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 266
    :sswitch_0
    nop

    .line 271
    iput-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    iput-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_rootNode:Lorg/w3c/dom/Node;

    .line 272
    return-void

    .line 246
    :cond_0
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "Can not pass null Node for constructing a DOM-based XMLStreamReader"

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    nop

    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_0
        0x9 -> :sswitch_0
        0xb -> :sswitch_0
    .end sparse-switch
.end method

.method private _calcNsAndAttrLists(Z)V
    .locals 9
    .param p1, "attrsToo"    # Z

    .line 2195
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    invoke-interface {v0}, Lorg/w3c/dom/Node;->getAttributes()Lorg/w3c/dom/NamedNodeMap;

    move-result-object v0

    .line 2198
    .local v0, "attrsIn":Lorg/w3c/dom/NamedNodeMap;
    invoke-interface {v0}, Lorg/w3c/dom/NamedNodeMap;->getLength()I

    move-result v1

    .line 2199
    .local v1, "len":I
    if-nez v1, :cond_0

    .line 2200
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v2

    iput-object v2, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_attrList:Ljava/util/List;

    .line 2201
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v2

    iput-object v2, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_nsDeclList:Ljava/util/List;

    .line 2202
    return-void

    .line 2205
    :cond_0
    iget-boolean v2, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_cfgNsAware:Z

    if-nez v2, :cond_2

    .line 2206
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v2, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_attrList:Ljava/util/List;

    .line 2207
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    if-ge v2, v1, :cond_1

    .line 2208
    iget-object v3, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_attrList:Ljava/util/List;

    invoke-interface {v0, v2}, Lorg/w3c/dom/NamedNodeMap;->item(I)Lorg/w3c/dom/Node;

    move-result-object v4

    invoke-interface {v3, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 2207
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 2210
    .end local v2    # "i":I
    :cond_1
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v2

    iput-object v2, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_nsDeclList:Ljava/util/List;

    .line 2211
    return-void

    .line 2215
    :cond_2
    const/4 v2, 0x0

    .line 2216
    .local v2, "attrsOut":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lorg/w3c/dom/Node;>;"
    const/4 v3, 0x0

    .line 2218
    .local v3, "nsOut":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    const/4 v4, 0x0

    .local v4, "i":I
    :goto_1
    if-ge v4, v1, :cond_b

    .line 2219
    invoke-interface {v0, v4}, Lorg/w3c/dom/NamedNodeMap;->item(I)Lorg/w3c/dom/Node;

    move-result-object v5

    .line 2220
    .local v5, "attr":Lorg/w3c/dom/Node;
    invoke-interface {v5}, Lorg/w3c/dom/Node;->getPrefix()Ljava/lang/String;

    move-result-object v6

    .line 2223
    .local v6, "prefix":Ljava/lang/String;
    const-string v7, "xmlns"

    if-eqz v6, :cond_6

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v8

    if-nez v8, :cond_3

    goto :goto_2

    .line 2236
    :cond_3
    invoke-virtual {v7, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_5

    .line 2237
    if-eqz p1, :cond_a

    .line 2238
    if-nez v2, :cond_4

    .line 2239
    new-instance v7, Ljava/util/ArrayList;

    sub-int v8, v1, v4

    invoke-direct {v7, v8}, Ljava/util/ArrayList;-><init>(I)V

    move-object v2, v7

    .line 2241
    :cond_4
    invoke-virtual {v2, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_4

    .line 2245
    :cond_5
    invoke-interface {v5}, Lorg/w3c/dom/Node;->getLocalName()Ljava/lang/String;

    move-result-object v6

    goto :goto_3

    .line 2225
    :cond_6
    :goto_2
    invoke-interface {v5}, Lorg/w3c/dom/Node;->getLocalName()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_8

    .line 2226
    if-eqz p1, :cond_a

    .line 2227
    if-nez v2, :cond_7

    .line 2228
    new-instance v7, Ljava/util/ArrayList;

    sub-int v8, v1, v4

    invoke-direct {v7, v8}, Ljava/util/ArrayList;-><init>(I)V

    move-object v2, v7

    .line 2230
    :cond_7
    invoke-virtual {v2, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_4

    .line 2234
    :cond_8
    const/4 v6, 0x0

    .line 2247
    :goto_3
    if-nez v3, :cond_9

    .line 2248
    new-instance v7, Ljava/util/ArrayList;

    sub-int v8, v1, v4

    mul-int/lit8 v8, v8, 0x2

    invoke-direct {v7, v8}, Ljava/util/ArrayList;-><init>(I)V

    move-object v3, v7

    .line 2250
    :cond_9
    invoke-virtual {p0, v6}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_internName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v3, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 2251
    invoke-interface {v5}, Lorg/w3c/dom/Node;->getNodeValue()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {p0, v7}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_internNsURI(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v3, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 2218
    .end local v5    # "attr":Lorg/w3c/dom/Node;
    .end local v6    # "prefix":Ljava/lang/String;
    :cond_a
    :goto_4
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .line 2254
    .end local v4    # "i":I
    :cond_b
    if-nez v2, :cond_c

    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v4

    goto :goto_5

    :cond_c
    move-object v4, v2

    :goto_5
    iput-object v4, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_attrList:Ljava/util/List;

    .line 2255
    if-nez v3, :cond_d

    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v4

    goto :goto_6

    :cond_d
    move-object v4, v3

    :goto_6
    iput-object v4, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_nsDeclList:Ljava/util/List;

    .line 2256
    return-void
.end method

.method private _constructQName(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljavax/xml/namespace/QName;
    .locals 4
    .param p1, "uri"    # Ljava/lang/String;
    .param p2, "ln"    # Ljava/lang/String;
    .param p3, "prefix"    # Ljava/lang/String;

    .line 2186
    new-instance v0, Ljavax/xml/namespace/QName;

    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_internNsURI(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, p2}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_internName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, p3}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_internName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v0, v1, v2, v3}, Ljavax/xml/namespace/QName;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-object v0
.end method

.method private _safeGetLocalName(Lorg/w3c/dom/Node;)Ljava/lang/String;
    .locals 1
    .param p1, "n"    # Lorg/w3c/dom/Node;

    .line 2282
    invoke-interface {p1}, Lorg/w3c/dom/Node;->getLocalName()Ljava/lang/String;

    move-result-object v0

    .line 2283
    .local v0, "ln":Ljava/lang/String;
    if-nez v0, :cond_0

    .line 2284
    invoke-interface {p1}, Lorg/w3c/dom/Node;->getNodeName()Ljava/lang/String;

    move-result-object v0

    .line 2286
    :cond_0
    return-object v0
.end method

.method private final checkExpand(Lorg/codehaus/stax2/typed/TypedArrayDecoder;)Z
    .locals 1
    .param p1, "tad"    # Lorg/codehaus/stax2/typed/TypedArrayDecoder;

    .line 1735
    instance-of v0, p1, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BaseArrayDecoder;

    if-eqz v0, :cond_0

    .line 1736
    move-object v0, p1

    check-cast v0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BaseArrayDecoder;

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BaseArrayDecoder;->expand()V

    .line 1737
    const/4 v0, 0x1

    return v0

    .line 1739
    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method private coalesceTypedText(Lorg/w3c/dom/Node;)Ljava/lang/String;
    .locals 3
    .param p1, "firstNode"    # Lorg/w3c/dom/Node;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1409
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_textBuffer:Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;->reset()V

    .line 1410
    const/4 v0, 0x0

    iput-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_attrList:Ljava/util/List;

    .line 1412
    move-object v0, p1

    .local v0, "n":Lorg/w3c/dom/Node;
    :goto_0
    if-eqz v0, :cond_0

    .line 1413
    invoke-interface {v0}, Lorg/w3c/dom/Node;->getNodeType()S

    move-result v1

    packed-switch v1, :pswitch_data_0

    .line 1428
    :pswitch_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unexpected DOM node type ("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-interface {v0}, Lorg/w3c/dom/Node;->getNodeType()S

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ") when trying to decode Typed content"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->throwStreamException(Ljava/lang/String;)V

    goto :goto_1

    .line 1424
    :pswitch_1
    goto :goto_1

    .line 1416
    :pswitch_2
    const-string v1, "Element content can not contain child START_ELEMENT when using Typed Access methods"

    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->throwStreamException(Ljava/lang/String;)V

    .line 1419
    :pswitch_3
    iget-object v1, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_textBuffer:Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;

    invoke-interface {v0}, Lorg/w3c/dom/Node;->getNodeValue()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;->append(Ljava/lang/String;)V

    .line 1420
    nop

    .line 1412
    :goto_1
    invoke-interface {v0}, Lorg/w3c/dom/Node;->getNextSibling()Lorg/w3c/dom/Node;

    move-result-object v0

    goto :goto_0

    .line 1431
    .end local v0    # "n":Lorg/w3c/dom/Node;
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_textBuffer:Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;->get()Ljava/lang/String;

    move-result-object v0

    return-object v0

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_0
        :pswitch_3
        :pswitch_3
        :pswitch_0
        :pswitch_0
        :pswitch_1
        :pswitch_1
    .end packed-switch
.end method

.method private handleIllegalAttrIndex(I)V
    .locals 5
    .param p1, "index"    # I

    .line 2260
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    check-cast v0, Lorg/w3c/dom/Element;

    .line 2261
    .local v0, "elem":Lorg/w3c/dom/Element;
    invoke-interface {v0}, Lorg/w3c/dom/Element;->getAttributes()Lorg/w3c/dom/NamedNodeMap;

    move-result-object v1

    .line 2262
    .local v1, "attrs":Lorg/w3c/dom/NamedNodeMap;
    invoke-interface {v1}, Lorg/w3c/dom/NamedNodeMap;->getLength()I

    move-result v2

    .line 2263
    .local v2, "len":I
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Illegal attribute index "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "; element <"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-interface {v0}, Lorg/w3c/dom/Element;->getNodeName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "> has "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    if-nez v2, :cond_0

    const-string v4, "no"

    goto :goto_0

    :cond_0
    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v4

    :goto_0
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " attributes"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 2264
    .local v3, "msg":Ljava/lang/String;
    new-instance v4, Ljava/lang/IllegalArgumentException;

    invoke-direct {v4, v3}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v4
.end method

.method private handleIllegalNsIndex(I)V
    .locals 2
    .param p1, "index"    # I

    .line 2269
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Illegal namespace declaration index "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " (has "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getNamespaceCount()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " ns declarations)"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 2270
    .local v0, "msg":Ljava/lang/String;
    new-instance v1, Ljava/lang/IllegalArgumentException;

    invoke-direct {v1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1
.end method


# virtual methods
.method protected _base64Decoder()Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;
    .locals 1

    .line 2367
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_base64Decoder:Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;

    if-nez v0, :cond_0

    .line 2368
    new-instance v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;

    invoke-direct {v0}, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;-><init>()V

    iput-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_base64Decoder:Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;

    .line 2370
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_base64Decoder:Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;

    return-object v0
.end method

.method protected _constructTypeException(Ljava/lang/IllegalArgumentException;Ljava/lang/String;)Lorg/codehaus/stax2/typed/TypedXMLStreamException;
    .locals 3
    .param p1, "iae"    # Ljava/lang/IllegalArgumentException;
    .param p2, "lexicalValue"    # Ljava/lang/String;

    .line 2331
    invoke-virtual {p1}, Ljava/lang/IllegalArgumentException;->getMessage()Ljava/lang/String;

    move-result-object v0

    .line 2332
    .local v0, "msg":Ljava/lang/String;
    if-nez v0, :cond_0

    .line 2333
    const-string v0, ""

    .line 2335
    :cond_0
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getStartLocation()Lorg/codehaus/stax2/XMLStreamLocation2;

    move-result-object v1

    .line 2336
    .local v1, "loc":Ljavax/xml/stream/Location;
    if-nez v1, :cond_1

    .line 2337
    new-instance v2, Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    invoke-direct {v2, p2, v0, p1}, Lorg/codehaus/stax2/typed/TypedXMLStreamException;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/IllegalArgumentException;)V

    return-object v2

    .line 2339
    :cond_1
    new-instance v2, Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    invoke-direct {v2, p2, v0, v1}, Lorg/codehaus/stax2/typed/TypedXMLStreamException;-><init>(Ljava/lang/String;Ljava/lang/String;Ljavax/xml/stream/Location;)V

    return-object v2
.end method

.method protected _constructTypeException(Ljava/lang/String;Ljava/lang/String;)Lorg/codehaus/stax2/typed/TypedXMLStreamException;
    .locals 2
    .param p1, "msg"    # Ljava/lang/String;
    .param p2, "lexicalValue"    # Ljava/lang/String;

    .line 2344
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getStartLocation()Lorg/codehaus/stax2/XMLStreamLocation2;

    move-result-object v0

    .line 2345
    .local v0, "loc":Ljavax/xml/stream/Location;
    if-nez v0, :cond_0

    .line 2346
    new-instance v1, Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    invoke-direct {v1, p2, p1}, Lorg/codehaus/stax2/typed/TypedXMLStreamException;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    return-object v1

    .line 2348
    :cond_0
    new-instance v1, Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    invoke-direct {v1, p2, p1, v0}, Lorg/codehaus/stax2/typed/TypedXMLStreamException;-><init>(Ljava/lang/String;Ljava/lang/String;Ljavax/xml/stream/Location;)V

    return-object v1
.end method

.method protected _decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;
    .locals 1

    .line 2359
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_decoderFactory:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    if-nez v0, :cond_0

    .line 2360
    new-instance v0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    invoke-direct {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;-><init>()V

    iput-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_decoderFactory:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    .line 2362
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_decoderFactory:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    return-object v0
.end method

.method protected _getAttributeAsArray(Lorg/codehaus/stax2/typed/TypedArrayDecoder;Ljava/lang/String;)I
    .locals 9
    .param p1, "tad"    # Lorg/codehaus/stax2/typed/TypedArrayDecoder;
    .param p2, "attrValue"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1687
    const/4 v0, 0x0

    .line 1688
    .local v0, "ptr":I
    const/4 v1, 0x0

    .line 1689
    .local v1, "start":I
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v2

    .line 1690
    .local v2, "end":I
    const/4 v3, 0x0

    .line 1691
    .local v3, "lexical":Ljava/lang/String;
    const/4 v4, 0x0

    .line 1695
    .local v4, "count":I
    :goto_0
    if-ge v0, v2, :cond_4

    .line 1697
    :cond_0
    :try_start_0
    invoke-virtual {p2, v0}, Ljava/lang/String;->charAt(I)C

    move-result v5

    const/16 v6, 0x20

    if-gt v5, v6, :cond_1

    .line 1698
    add-int/lit8 v0, v0, 0x1

    if-lt v0, v2, :cond_0

    .line 1699
    goto :goto_2

    .line 1703
    :cond_1
    move v1, v0

    .line 1704
    add-int/lit8 v0, v0, 0x1

    .line 1705
    :goto_1
    if-ge v0, v2, :cond_2

    invoke-virtual {p2, v0}, Ljava/lang/String;->charAt(I)C

    move-result v5

    if-le v5, v6, :cond_2

    .line 1706
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 1708
    :cond_2
    move v5, v0

    .line 1709
    .local v5, "tokenEnd":I
    add-int/lit8 v0, v0, 0x1

    .line 1711
    invoke-virtual {p2, v1, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v6

    move-object v3, v6

    .line 1712
    add-int/lit8 v4, v4, 0x1

    .line 1713
    invoke-virtual {p1, v3}, Lorg/codehaus/stax2/typed/TypedArrayDecoder;->decodeValue(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_3

    .line 1714
    invoke-direct {p0, p1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->checkExpand(Lorg/codehaus/stax2/typed/TypedArrayDecoder;)Z

    move-result v6
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    if-nez v6, :cond_3

    .line 1715
    goto :goto_2

    .line 1718
    .end local v5    # "tokenEnd":I
    :cond_3
    goto :goto_0

    .line 1719
    :catch_0
    move-exception v5

    .line 1721
    .local v5, "iae":Ljava/lang/IllegalArgumentException;
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getLocation()Ljavax/xml/stream/Location;

    move-result-object v6

    .line 1722
    .local v6, "loc":Ljavax/xml/stream/Location;
    new-instance v7, Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    invoke-virtual {v5}, Ljava/lang/IllegalArgumentException;->getMessage()Ljava/lang/String;

    move-result-object v8

    invoke-direct {v7, v3, v8, v6, v5}, Lorg/codehaus/stax2/typed/TypedXMLStreamException;-><init>(Ljava/lang/String;Ljava/lang/String;Ljavax/xml/stream/Location;Ljava/lang/IllegalArgumentException;)V

    throw v7

    .line 1723
    .end local v5    # "iae":Ljava/lang/IllegalArgumentException;
    .end local v6    # "loc":Ljavax/xml/stream/Location;
    :cond_4
    :goto_2
    nop

    .line 1724
    return v4
.end method

.method protected _internName(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .line 2408
    if-nez p1, :cond_0

    .line 2409
    const-string v0, ""

    return-object v0

    .line 2411
    :cond_0
    iget-boolean v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_cfgInternNames:Z

    if-eqz v0, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->intern()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_1
    move-object v0, p1

    :goto_0
    return-object v0
.end method

.method protected _internNsURI(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p1, "uri"    # Ljava/lang/String;

    .line 2416
    if-nez p1, :cond_0

    .line 2417
    const-string v0, ""

    return-object v0

    .line 2419
    :cond_0
    iget-boolean v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_cfgInternNsURIs:Z

    if-eqz v0, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->intern()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_1
    move-object v0, p1

    :goto_0
    return-object v0
.end method

.method public close()V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1079
    return-void
.end method

.method public closeCompletely()V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2002
    return-void
.end method

.method protected coalesceText(I)V
    .locals 4
    .param p1, "initialType"    # I

    .line 2159
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_textBuffer:Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;->reset()V

    .line 2160
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_textBuffer:Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;

    iget-object v1, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    invoke-interface {v1}, Lorg/w3c/dom/Node;->getNodeValue()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;->append(Ljava/lang/String;)V

    .line 2163
    :goto_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    invoke-interface {v0}, Lorg/w3c/dom/Node;->getNextSibling()Lorg/w3c/dom/Node;

    move-result-object v0

    move-object v1, v0

    .local v1, "n":Lorg/w3c/dom/Node;
    const/4 v2, 0x4

    if-eqz v0, :cond_1

    .line 2164
    invoke-interface {v1}, Lorg/w3c/dom/Node;->getNodeType()S

    move-result v0

    .line 2165
    .local v0, "type":I
    const/4 v3, 0x3

    if-eq v0, v3, :cond_0

    if-eq v0, v2, :cond_0

    .line 2166
    goto :goto_1

    .line 2168
    :cond_0
    iput-object v1, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    .line 2169
    iget-object v2, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_textBuffer:Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;

    iget-object v3, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    invoke-interface {v3}, Lorg/w3c/dom/Node;->getNodeValue()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;->append(Ljava/lang/String;)V

    .line 2170
    .end local v0    # "type":I
    goto :goto_0

    .line 2171
    :cond_1
    :goto_1
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_textBuffer:Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;->get()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_coalescedText:Ljava/lang/String;

    .line 2174
    iput v2, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    .line 2175
    return-void
.end method

.method public findAttributeIndex(Ljava/lang/String;Ljava/lang/String;)I
    .locals 10
    .param p1, "nsURI"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;

    .line 1824
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    .line 1825
    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->reportWrongState(I)V

    .line 1827
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    check-cast v0, Lorg/w3c/dom/Element;

    .line 1828
    .local v0, "elem":Lorg/w3c/dom/Element;
    invoke-interface {v0}, Lorg/w3c/dom/Element;->getAttributes()Lorg/w3c/dom/NamedNodeMap;

    move-result-object v2

    .line 1829
    .local v2, "attrs":Lorg/w3c/dom/NamedNodeMap;
    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v3

    if-nez v3, :cond_1

    .line 1830
    const/4 p1, 0x0

    .line 1833
    :cond_1
    const/4 v3, 0x0

    .local v3, "i":I
    invoke-interface {v2}, Lorg/w3c/dom/NamedNodeMap;->getLength()I

    move-result v4

    .local v4, "len":I
    :goto_0
    if-ge v3, v4, :cond_6

    .line 1834
    invoke-interface {v2, v3}, Lorg/w3c/dom/NamedNodeMap;->item(I)Lorg/w3c/dom/Node;

    move-result-object v5

    .line 1835
    .local v5, "attr":Lorg/w3c/dom/Node;
    invoke-direct {p0, v5}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_safeGetLocalName(Lorg/w3c/dom/Node;)Ljava/lang/String;

    move-result-object v6

    .line 1836
    .local v6, "ln":Ljava/lang/String;
    invoke-virtual {p2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_5

    .line 1837
    invoke-interface {v5}, Lorg/w3c/dom/Node;->getNamespaceURI()Ljava/lang/String;

    move-result-object v7

    .line 1838
    .local v7, "thisUri":Ljava/lang/String;
    if-eqz v7, :cond_3

    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v8

    if-nez v8, :cond_2

    goto :goto_1

    :cond_2
    const/4 v8, 0x0

    goto :goto_2

    :cond_3
    :goto_1
    move v8, v1

    .line 1839
    .local v8, "isEmpty":Z
    :goto_2
    if-nez p1, :cond_4

    .line 1840
    if-eqz v8, :cond_5

    .line 1841
    return v3

    .line 1844
    :cond_4
    if-nez v8, :cond_5

    invoke-virtual {p1, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_5

    .line 1845
    return v3

    .line 1833
    .end local v5    # "attr":Lorg/w3c/dom/Node;
    .end local v6    # "ln":Ljava/lang/String;
    .end local v7    # "thisUri":Ljava/lang/String;
    .end local v8    # "isEmpty":Z
    :cond_5
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 1850
    .end local v3    # "i":I
    .end local v4    # "len":I
    :cond_6
    const/4 v1, -0x1

    return v1
.end method

.method protected findErrorDesc(II)Ljava/lang/String;
    .locals 3
    .param p1, "errorType"    # I
    .param p2, "currEvent"    # I

    .line 2380
    invoke-static {p2}, Lorg/codehaus/stax2/ri/Stax2Util;->eventTypeDesc(I)Ljava/lang/String;

    move-result-object v0

    .line 2381
    .local v0, "evtDesc":Ljava/lang/String;
    const-string v1, "Current event "

    const-string v2, "Current event ("

    packed-switch p1, :pswitch_data_0

    .line 2399
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Internal error (unrecognized error type: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 2387
    :pswitch_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ") has no local name"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 2394
    :pswitch_1
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " not START_ELEMENT, END_ELEMENT, CHARACTERS or CDATA"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 2396
    :pswitch_2
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", needs to be one of CHARACTERS, CDATA, SPACE or COMMENT"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 2392
    :pswitch_3
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ") not a textual event"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 2389
    :pswitch_4
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ") needs to be PROCESSING_INSTRUCTION"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 2385
    :pswitch_5
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", needs to be START_ELEMENT or END_ELEMENT"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 2383
    :pswitch_6
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", needs to be START_ELEMENT"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public final getAttributeAs(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V
    .locals 3
    .param p1, "index"    # I
    .param p2, "tvd"    # Lorg/codehaus/stax2/typed/TypedValueDecoder;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1634
    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getAttributeValue(I)Ljava/lang/String;

    move-result-object v0

    .line 1635
    .local v0, "value":Ljava/lang/String;
    invoke-static {v0}, Lorg/codehaus/stax2/ri/Stax2Util;->trimSpaces(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1637
    if-nez v0, :cond_0

    .line 1638
    :try_start_0
    invoke-virtual {p2}, Lorg/codehaus/stax2/typed/TypedValueDecoder;->handleEmptyValue()V

    goto :goto_0

    .line 1640
    :cond_0
    invoke-virtual {p2, v0}, Lorg/codehaus/stax2/typed/TypedValueDecoder;->decode(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1644
    :goto_0
    nop

    .line 1645
    return-void

    .line 1642
    :catch_0
    move-exception v1

    .line 1643
    .local v1, "iae":Ljava/lang/IllegalArgumentException;
    invoke-virtual {p0, v1, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_constructTypeException(Ljava/lang/IllegalArgumentException;Ljava/lang/String;)Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    move-result-object v2

    throw v2
.end method

.method public getAttributeAsArray(ILorg/codehaus/stax2/typed/TypedArrayDecoder;)I
    .locals 1
    .param p1, "index"    # I
    .param p2, "tad"    # Lorg/codehaus/stax2/typed/TypedArrayDecoder;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1682
    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getAttributeValue(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, p2, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_getAttributeAsArray(Lorg/codehaus/stax2/typed/TypedArrayDecoder;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public getAttributeAsBinary(I)[B
    .locals 1
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1745
    invoke-static {}, Lorg/codehaus/stax2/typed/Base64Variants;->getDefaultVariant()Lorg/codehaus/stax2/typed/Base64Variant;

    move-result-object v0

    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getAttributeAsBinary(ILorg/codehaus/stax2/typed/Base64Variant;)[B

    move-result-object v0

    return-object v0
.end method

.method public getAttributeAsBinary(ILorg/codehaus/stax2/typed/Base64Variant;)[B
    .locals 4
    .param p1, "index"    # I
    .param p2, "v"    # Lorg/codehaus/stax2/typed/Base64Variant;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1751
    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getAttributeValue(I)Ljava/lang/String;

    move-result-object v0

    .line 1752
    .local v0, "lexical":Ljava/lang/String;
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_base64Decoder()Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;

    move-result-object v1

    .line 1753
    .local v1, "dec":Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;
    const/4 v2, 0x1

    invoke-virtual {v1, p2, v2, v0}, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->init(Lorg/codehaus/stax2/typed/Base64Variant;ZLjava/lang/String;)V

    .line 1755
    :try_start_0
    invoke-virtual {v1}, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->decodeCompletely()[B

    move-result-object v2
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v2

    .line 1756
    :catch_0
    move-exception v2

    .line 1757
    .local v2, "iae":Ljava/lang/IllegalArgumentException;
    invoke-virtual {p0, v2, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_constructTypeException(Ljava/lang/IllegalArgumentException;Ljava/lang/String;)Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    move-result-object v3

    throw v3
.end method

.method public getAttributeAsBoolean(I)Z
    .locals 2
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1570
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getBooleanDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;

    move-result-object v0

    .line 1571
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;
    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getAttributeAs(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 1572
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;->getValue()Z

    move-result v1

    return v1
.end method

.method public getAttributeAsDecimal(I)Ljava/math/BigDecimal;
    .locals 2
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1618
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getDecimalDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecimalDecoder;

    move-result-object v0

    .line 1619
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecimalDecoder;
    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getAttributeAs(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 1620
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecimalDecoder;->getValue()Ljava/math/BigDecimal;

    move-result-object v1

    return-object v1
.end method

.method public getAttributeAsDouble(I)D
    .locals 3
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1602
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getDoubleDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;

    move-result-object v0

    .line 1603
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;
    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getAttributeAs(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 1604
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;->getValue()D

    move-result-wide v1

    return-wide v1
.end method

.method public getAttributeAsDoubleArray(I)[D
    .locals 2
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1674
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getDoubleArrayDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;

    move-result-object v0

    .line 1675
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;
    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getAttributeValue(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_getAttributeAsArray(Lorg/codehaus/stax2/typed/TypedArrayDecoder;Ljava/lang/String;)I

    .line 1676
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;->getValues()[D

    move-result-object v1

    return-object v1
.end method

.method public getAttributeAsFloat(I)F
    .locals 2
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1594
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getFloatDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;

    move-result-object v0

    .line 1595
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;
    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getAttributeAs(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 1596
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;->getValue()F

    move-result v1

    return v1
.end method

.method public getAttributeAsFloatArray(I)[F
    .locals 2
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1666
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getFloatArrayDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;

    move-result-object v0

    .line 1667
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;
    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getAttributeValue(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_getAttributeAsArray(Lorg/codehaus/stax2/typed/TypedArrayDecoder;Ljava/lang/String;)I

    .line 1668
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;->getValues()[F

    move-result-object v1

    return-object v1
.end method

.method public getAttributeAsInt(I)I
    .locals 2
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1578
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getIntDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;

    move-result-object v0

    .line 1579
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;
    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getAttributeAs(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 1580
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;->getValue()I

    move-result v1

    return v1
.end method

.method public getAttributeAsIntArray(I)[I
    .locals 2
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1650
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getIntArrayDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;

    move-result-object v0

    .line 1651
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;
    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getAttributeValue(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_getAttributeAsArray(Lorg/codehaus/stax2/typed/TypedArrayDecoder;Ljava/lang/String;)I

    .line 1652
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;->getValues()[I

    move-result-object v1

    return-object v1
.end method

.method public getAttributeAsInteger(I)Ljava/math/BigInteger;
    .locals 2
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1610
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getIntegerDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntegerDecoder;

    move-result-object v0

    .line 1611
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntegerDecoder;
    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getAttributeAs(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 1612
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntegerDecoder;->getValue()Ljava/math/BigInteger;

    move-result-object v1

    return-object v1
.end method

.method public getAttributeAsLong(I)J
    .locals 3
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1586
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getLongDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;

    move-result-object v0

    .line 1587
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;
    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getAttributeAs(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 1588
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;->getValue()J

    move-result-wide v1

    return-wide v1
.end method

.method public getAttributeAsLongArray(I)[J
    .locals 2
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1658
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getLongArrayDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;

    move-result-object v0

    .line 1659
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;
    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getAttributeValue(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_getAttributeAsArray(Lorg/codehaus/stax2/typed/TypedArrayDecoder;Ljava/lang/String;)I

    .line 1660
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;->getValues()[J

    move-result-object v1

    return-object v1
.end method

.method public getAttributeAsQName(I)Ljavax/xml/namespace/QName;
    .locals 2
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1626
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getNamespaceContext()Ljavax/xml/namespace/NamespaceContext;

    move-result-object v1

    invoke-virtual {v0, v1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getQNameDecoder(Ljavax/xml/namespace/NamespaceContext;)Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;

    move-result-object v0

    .line 1627
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;
    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getAttributeAs(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 1628
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;->getValue()Ljavax/xml/namespace/QName;

    move-result-object v1

    return-object v1
.end method

.method public getAttributeCount()I
    .locals 2

    .line 376
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    .line 377
    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->reportWrongState(I)V

    .line 379
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_attrList:Ljava/util/List;

    if-nez v0, :cond_1

    .line 380
    invoke-direct {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_calcNsAndAttrLists(Z)V

    .line 382
    :cond_1
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_attrList:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public getAttributeIndex(Ljava/lang/String;Ljava/lang/String;)I
    .locals 1
    .param p1, "namespaceURI"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;

    .line 1564
    invoke-virtual {p0, p1, p2}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->findAttributeIndex(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public getAttributeInfo()Lorg/codehaus/stax2/AttributeInfo;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1811
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    .line 1812
    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->reportWrongState(I)V

    .line 1814
    :cond_0
    return-object p0
.end method

.method public getAttributeLocalName(I)Ljava/lang/String;
    .locals 2
    .param p1, "index"    # I

    .line 388
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    .line 389
    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->reportWrongState(I)V

    .line 391
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_attrList:Ljava/util/List;

    if-nez v0, :cond_1

    .line 392
    invoke-direct {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_calcNsAndAttrLists(Z)V

    .line 394
    :cond_1
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_attrList:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge p1, v0, :cond_3

    if-gez p1, :cond_2

    goto :goto_0

    .line 398
    :cond_2
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_attrList:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/w3c/dom/Attr;

    .line 399
    .local v0, "attr":Lorg/w3c/dom/Attr;
    invoke-direct {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_safeGetLocalName(Lorg/w3c/dom/Node;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_internName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 395
    .end local v0    # "attr":Lorg/w3c/dom/Attr;
    :cond_3
    :goto_0
    invoke-direct {p0, p1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->handleIllegalAttrIndex(I)V

    .line 396
    const/4 v0, 0x0

    return-object v0
.end method

.method public getAttributeName(I)Ljavax/xml/namespace/QName;
    .locals 4
    .param p1, "index"    # I

    .line 405
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    .line 406
    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->reportWrongState(I)V

    .line 408
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_attrList:Ljava/util/List;

    if-nez v0, :cond_1

    .line 409
    invoke-direct {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_calcNsAndAttrLists(Z)V

    .line 411
    :cond_1
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_attrList:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge p1, v0, :cond_3

    if-gez p1, :cond_2

    goto :goto_0

    .line 415
    :cond_2
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_attrList:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/w3c/dom/Attr;

    .line 416
    .local v0, "attr":Lorg/w3c/dom/Attr;
    invoke-interface {v0}, Lorg/w3c/dom/Attr;->getNamespaceURI()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_safeGetLocalName(Lorg/w3c/dom/Node;)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0}, Lorg/w3c/dom/Attr;->getPrefix()Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v1, v2, v3}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_constructQName(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljavax/xml/namespace/QName;

    move-result-object v1

    return-object v1

    .line 412
    .end local v0    # "attr":Lorg/w3c/dom/Attr;
    :cond_3
    :goto_0
    invoke-direct {p0, p1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->handleIllegalAttrIndex(I)V

    .line 413
    const/4 v0, 0x0

    return-object v0
.end method

.method public getAttributeNamespace(I)Ljava/lang/String;
    .locals 2
    .param p1, "index"    # I

    .line 422
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    .line 423
    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->reportWrongState(I)V

    .line 425
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_attrList:Ljava/util/List;

    if-nez v0, :cond_1

    .line 426
    invoke-direct {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_calcNsAndAttrLists(Z)V

    .line 428
    :cond_1
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_attrList:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge p1, v0, :cond_3

    if-gez p1, :cond_2

    goto :goto_0

    .line 432
    :cond_2
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_attrList:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/w3c/dom/Attr;

    .line 433
    .local v0, "attr":Lorg/w3c/dom/Attr;
    invoke-interface {v0}, Lorg/w3c/dom/Attr;->getNamespaceURI()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_internNsURI(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 429
    .end local v0    # "attr":Lorg/w3c/dom/Attr;
    :cond_3
    :goto_0
    invoke-direct {p0, p1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->handleIllegalAttrIndex(I)V

    .line 430
    const/4 v0, 0x0

    return-object v0
.end method

.method public getAttributePrefix(I)Ljava/lang/String;
    .locals 2
    .param p1, "index"    # I

    .line 439
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    .line 440
    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->reportWrongState(I)V

    .line 442
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_attrList:Ljava/util/List;

    if-nez v0, :cond_1

    .line 443
    invoke-direct {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_calcNsAndAttrLists(Z)V

    .line 445
    :cond_1
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_attrList:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge p1, v0, :cond_3

    if-gez p1, :cond_2

    goto :goto_0

    .line 449
    :cond_2
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_attrList:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/w3c/dom/Attr;

    .line 450
    .local v0, "attr":Lorg/w3c/dom/Attr;
    invoke-interface {v0}, Lorg/w3c/dom/Attr;->getPrefix()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_internName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 446
    .end local v0    # "attr":Lorg/w3c/dom/Attr;
    :cond_3
    :goto_0
    invoke-direct {p0, p1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->handleIllegalAttrIndex(I)V

    .line 447
    const/4 v0, 0x0

    return-object v0
.end method

.method public getAttributeType(I)Ljava/lang/String;
    .locals 2
    .param p1, "index"    # I

    .line 456
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    .line 457
    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->reportWrongState(I)V

    .line 459
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_attrList:Ljava/util/List;

    if-nez v0, :cond_1

    .line 460
    invoke-direct {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_calcNsAndAttrLists(Z)V

    .line 462
    :cond_1
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_attrList:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge p1, v0, :cond_3

    if-gez p1, :cond_2

    goto :goto_0

    .line 480
    :cond_2
    const-string v0, "CDATA"

    return-object v0

    .line 463
    :cond_3
    :goto_0
    invoke-direct {p0, p1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->handleIllegalAttrIndex(I)V

    .line 464
    const/4 v0, 0x0

    return-object v0
.end method

.method public getAttributeValue(I)Ljava/lang/String;
    .locals 2
    .param p1, "index"    # I

    .line 486
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    .line 487
    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->reportWrongState(I)V

    .line 489
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_attrList:Ljava/util/List;

    if-nez v0, :cond_1

    .line 490
    invoke-direct {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_calcNsAndAttrLists(Z)V

    .line 492
    :cond_1
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_attrList:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge p1, v0, :cond_3

    if-gez p1, :cond_2

    goto :goto_0

    .line 496
    :cond_2
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_attrList:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/w3c/dom/Attr;

    .line 497
    .local v0, "attr":Lorg/w3c/dom/Attr;
    invoke-interface {v0}, Lorg/w3c/dom/Attr;->getValue()Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 493
    .end local v0    # "attr":Lorg/w3c/dom/Attr;
    :cond_3
    :goto_0
    invoke-direct {p0, p1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->handleIllegalAttrIndex(I)V

    .line 494
    const/4 v0, 0x0

    return-object v0
.end method

.method public getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .param p1, "nsURI"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;

    .line 503
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    .line 504
    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->reportWrongState(I)V

    .line 506
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    check-cast v0, Lorg/w3c/dom/Element;

    .line 507
    .local v0, "elem":Lorg/w3c/dom/Element;
    invoke-interface {v0}, Lorg/w3c/dom/Element;->getAttributes()Lorg/w3c/dom/NamedNodeMap;

    move-result-object v1

    .line 513
    .local v1, "attrs":Lorg/w3c/dom/NamedNodeMap;
    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    if-nez v2, :cond_1

    .line 514
    const/4 p1, 0x0

    .line 516
    :cond_1
    invoke-interface {v1, p1, p2}, Lorg/w3c/dom/NamedNodeMap;->getNamedItemNS(Ljava/lang/String;Ljava/lang/String;)Lorg/w3c/dom/Node;

    move-result-object v2

    check-cast v2, Lorg/w3c/dom/Attr;

    .line 517
    .local v2, "attr":Lorg/w3c/dom/Attr;
    if-nez v2, :cond_2

    const/4 v3, 0x0

    goto :goto_0

    :cond_2
    invoke-interface {v2}, Lorg/w3c/dom/Attr;->getValue()Ljava/lang/String;

    move-result-object v3

    :goto_0
    return-object v3
.end method

.method public getCharacterEncodingScheme()Ljava/lang/String;
    .locals 1

    .line 301
    const/4 v0, 0x0

    return-object v0
.end method

.method public getCurrentLocation()Lorg/codehaus/stax2/XMLStreamLocation2;
    .locals 1

    .line 2104
    sget-object v0, Lorg/codehaus/stax2/XMLStreamLocation2;->NOT_AVAILABLE:Lorg/codehaus/stax2/XMLStreamLocation2;

    return-object v0
.end method

.method public getDTDInfo()Lorg/codehaus/stax2/DTDInfo;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1885
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/16 v1, 0xb

    if-eq v0, v1, :cond_0

    .line 1886
    const/4 v0, 0x0

    return-object v0

    .line 1888
    :cond_0
    return-object p0
.end method

.method public getDTDInternalSubset()Ljava/lang/String;
    .locals 1

    .line 2049
    const/4 v0, 0x0

    return-object v0
.end method

.method public getDTDPublicId()Ljava/lang/String;
    .locals 2

    .line 2025
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/16 v1, 0xb

    if-ne v0, v1, :cond_0

    .line 2026
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    check-cast v0, Lorg/w3c/dom/DocumentType;

    invoke-interface {v0}, Lorg/w3c/dom/DocumentType;->getPublicId()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 2028
    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public getDTDRootName()Ljava/lang/String;
    .locals 2

    .line 2017
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/16 v1, 0xb

    if-ne v0, v1, :cond_0

    .line 2018
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    check-cast v0, Lorg/w3c/dom/DocumentType;

    invoke-interface {v0}, Lorg/w3c/dom/DocumentType;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_internName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 2020
    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public getDTDSystemId()Ljava/lang/String;
    .locals 2

    .line 2033
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/16 v1, 0xb

    if-ne v0, v1, :cond_0

    .line 2034
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    check-cast v0, Lorg/w3c/dom/DocumentType;

    invoke-interface {v0}, Lorg/w3c/dom/DocumentType;->getSystemId()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 2036
    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public getDepth()I
    .locals 1

    .line 1942
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_depth:I

    return v0
.end method

.method public getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V
    .locals 3
    .param p1, "tvd"    # Lorg/codehaus/stax2/typed/TypedValueDecoder;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1277
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getElementText()Ljava/lang/String;

    move-result-object v0

    .line 1278
    .local v0, "value":Ljava/lang/String;
    invoke-static {v0}, Lorg/codehaus/stax2/ri/Stax2Util;->trimSpaces(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1280
    if-nez v0, :cond_0

    .line 1281
    :try_start_0
    invoke-virtual {p1}, Lorg/codehaus/stax2/typed/TypedValueDecoder;->handleEmptyValue()V

    goto :goto_0

    .line 1283
    :cond_0
    invoke-virtual {p1, v0}, Lorg/codehaus/stax2/typed/TypedValueDecoder;->decode(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1287
    :goto_0
    nop

    .line 1288
    return-void

    .line 1285
    :catch_0
    move-exception v1

    .line 1286
    .local v1, "iae":Ljava/lang/IllegalArgumentException;
    invoke-virtual {p0, v1, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_constructTypeException(Ljava/lang/IllegalArgumentException;Ljava/lang/String;)Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    move-result-object v2

    throw v2
.end method

.method public getElementAsBinary()[B
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1250
    invoke-static {}, Lorg/codehaus/stax2/typed/Base64Variants;->getDefaultVariant()Lorg/codehaus/stax2/typed/Base64Variant;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getElementAsBinary(Lorg/codehaus/stax2/typed/Base64Variant;)[B

    move-result-object v0

    return-object v0
.end method

.method public getElementAsBinary(Lorg/codehaus/stax2/typed/Base64Variant;)[B
    .locals 6
    .param p1, "v"    # Lorg/codehaus/stax2/typed/Base64Variant;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1257
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_base64Decoder()Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->getByteAggregator()Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;

    move-result-object v0

    .line 1258
    .local v0, "aggr":Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;->startAggregation()[B

    move-result-object v1

    .line 1260
    .local v1, "buffer":[B
    :goto_0
    const/4 v2, 0x0

    .line 1261
    .local v2, "offset":I
    array-length v3, v1

    .line 1263
    .local v3, "len":I
    :cond_0
    invoke-virtual {p0, v1, v2, v3, p1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->readElementAsBinary([BIILorg/codehaus/stax2/typed/Base64Variant;)I

    move-result v4

    .line 1264
    .local v4, "readCount":I
    const/4 v5, 0x1

    if-ge v4, v5, :cond_1

    .line 1265
    invoke-virtual {v0, v1, v2}, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;->aggregateAll([BI)[B

    move-result-object v5

    return-object v5

    .line 1267
    :cond_1
    add-int/2addr v2, v4

    .line 1268
    sub-int/2addr v3, v4

    .line 1269
    .end local v4    # "readCount":I
    if-gtz v3, :cond_0

    .line 1270
    invoke-virtual {v0, v1}, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;->addFullBlock([B)[B

    move-result-object v1

    .line 1271
    .end local v2    # "offset":I
    .end local v3    # "len":I
    goto :goto_0
.end method

.method public getElementAsBoolean()Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1186
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getBooleanDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;

    move-result-object v0

    .line 1187
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 1188
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;->getValue()Z

    move-result v1

    return v1
.end method

.method public getElementAsDecimal()Ljava/math/BigDecimal;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1234
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getDecimalDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecimalDecoder;

    move-result-object v0

    .line 1235
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecimalDecoder;
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 1236
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecimalDecoder;->getValue()Ljava/math/BigDecimal;

    move-result-object v1

    return-object v1
.end method

.method public getElementAsDouble()D
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1218
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getDoubleDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;

    move-result-object v0

    .line 1219
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 1220
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;->getValue()D

    move-result-wide v1

    return-wide v1
.end method

.method public getElementAsFloat()F
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1210
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getFloatDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;

    move-result-object v0

    .line 1211
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 1212
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;->getValue()F

    move-result v1

    return v1
.end method

.method public getElementAsInt()I
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1194
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getIntDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;

    move-result-object v0

    .line 1195
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 1196
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;->getValue()I

    move-result v1

    return v1
.end method

.method public getElementAsInteger()Ljava/math/BigInteger;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1226
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getIntegerDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntegerDecoder;

    move-result-object v0

    .line 1227
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntegerDecoder;
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 1228
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntegerDecoder;->getValue()Ljava/math/BigInteger;

    move-result-object v1

    return-object v1
.end method

.method public getElementAsLong()J
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1202
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getLongDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;

    move-result-object v0

    .line 1203
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 1204
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;->getValue()J

    move-result-wide v1

    return-wide v1
.end method

.method public getElementAsQName()Ljavax/xml/namespace/QName;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1242
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getNamespaceContext()Ljavax/xml/namespace/NamespaceContext;

    move-result-object v1

    invoke-virtual {v0, v1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getQNameDecoder(Ljavax/xml/namespace/NamespaceContext;)Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;

    move-result-object v0

    .line 1243
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 1244
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;->getValue()Ljavax/xml/namespace/QName;

    move-result-object v1

    return-object v1
.end method

.method public getElementText()Ljava/lang/String;
    .locals 9
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 534
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    .line 539
    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->reportParseProblem(I)V

    .line 542
    :cond_0
    iget-boolean v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_coalescing:Z

    const/4 v2, 0x4

    const/4 v3, 0x3

    const/4 v4, 0x5

    const/4 v5, 0x2

    if-eqz v0, :cond_7

    .line 543
    const/4 v0, 0x0

    .line 546
    .local v0, "text":Ljava/lang/String;
    :cond_1
    :goto_0
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->next()I

    move-result v6

    .line 547
    .local v6, "type":I
    if-ne v6, v5, :cond_3

    .line 548
    nop

    .line 562
    .end local v6    # "type":I
    if-nez v0, :cond_2

    const-string v1, ""

    goto :goto_1

    :cond_2
    move-object v1, v0

    :goto_1
    return-object v1

    .line 550
    .restart local v6    # "type":I
    :cond_3
    if-eq v6, v4, :cond_1

    if-ne v6, v3, :cond_4

    .line 551
    goto :goto_0

    .line 553
    :cond_4
    shl-int v7, v1, v6

    and-int/lit16 v7, v7, 0x1250

    if-nez v7, :cond_5

    .line 554
    invoke-virtual {p0, v2}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->reportParseProblem(I)V

    .line 556
    :cond_5
    if-nez v0, :cond_6

    .line 557
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getText()Ljava/lang/String;

    move-result-object v0

    goto :goto_2

    .line 559
    :cond_6
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getText()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 561
    .end local v6    # "type":I
    :goto_2
    goto :goto_0

    .line 564
    .end local v0    # "text":Ljava/lang/String;
    :cond_7
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_textBuffer:Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;->reset()V

    .line 567
    :cond_8
    :goto_3
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->next()I

    move-result v0

    .line 568
    .local v0, "type":I
    if-ne v0, v5, :cond_9

    .line 569
    nop

    .line 579
    .end local v0    # "type":I
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_textBuffer:Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;->get()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 571
    .restart local v0    # "type":I
    :cond_9
    if-eq v0, v4, :cond_8

    if-ne v0, v3, :cond_a

    .line 572
    goto :goto_3

    .line 574
    :cond_a
    shl-int v6, v1, v0

    and-int/lit16 v6, v6, 0x1250

    if-nez v6, :cond_b

    .line 575
    invoke-virtual {p0, v2}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->reportParseProblem(I)V

    .line 577
    :cond_b
    iget-object v6, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_textBuffer:Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;

    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getText()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Lorg/codehaus/stax2/ri/Stax2Util$TextBuffer;->append(Ljava/lang/String;)V

    .line 578
    .end local v0    # "type":I
    goto :goto_3
.end method

.method public getEncoding()Ljava/lang/String;
    .locals 1

    .line 315
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getCharacterEncodingScheme()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final getEndLocation()Lorg/codehaus/stax2/XMLStreamLocation2;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2111
    sget-object v0, Lorg/codehaus/stax2/XMLStreamLocation2;->NOT_AVAILABLE:Lorg/codehaus/stax2/XMLStreamLocation2;

    return-object v0
.end method

.method public getEndingByteOffset()J
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2083
    const-wide/16 v0, -0x1

    return-wide v0
.end method

.method public getEndingCharOffset()J
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2090
    const-wide/16 v0, -0x1

    return-wide v0
.end method

.method protected getErrorLocation()Ljavax/xml/stream/Location;
    .locals 1

    .line 2314
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getCurrentLocation()Lorg/codehaus/stax2/XMLStreamLocation2;

    move-result-object v0

    .line 2315
    .local v0, "loc":Ljavax/xml/stream/Location;
    if-nez v0, :cond_0

    .line 2316
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getLocation()Ljavax/xml/stream/Location;

    move-result-object v0

    .line 2318
    :cond_0
    return-object v0
.end method

.method public getEventType()I
    .locals 1

    .line 589
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    return v0
.end method

.method public getFeature(Ljava/lang/String;)Ljava/lang/Object;
    .locals 3
    .param p1, "name"    # Ljava/lang/String;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 1774
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unrecognized feature \""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public getIdAttributeIndex()I
    .locals 1

    .line 1860
    const/4 v0, -0x1

    return v0
.end method

.method public getLocalName()Ljava/lang/String;
    .locals 2

    .line 595
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_2

    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    goto :goto_0

    .line 598
    :cond_0
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/16 v1, 0x9

    if-eq v0, v1, :cond_1

    .line 599
    const/4 v0, 0x7

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->reportWrongState(I)V

    .line 601
    :cond_1
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    invoke-interface {v0}, Lorg/w3c/dom/Node;->getNodeName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_internName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 596
    :cond_2
    :goto_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    invoke-direct {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_safeGetLocalName(Lorg/w3c/dom/Node;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_internName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final getLocation()Ljavax/xml/stream/Location;
    .locals 1

    .line 606
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getStartLocation()Lorg/codehaus/stax2/XMLStreamLocation2;

    move-result-object v0

    return-object v0
.end method

.method public final getLocationInfo()Lorg/codehaus/stax2/LocationInfo;
    .locals 0

    .line 1898
    return-object p0
.end method

.method public getName()Ljavax/xml/namespace/QName;
    .locals 3

    .line 612
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/4 v2, 0x2

    if-eq v0, v2, :cond_0

    .line 613
    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->reportWrongState(I)V

    .line 615
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    invoke-interface {v0}, Lorg/w3c/dom/Node;->getNamespaceURI()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    invoke-direct {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_safeGetLocalName(Lorg/w3c/dom/Node;)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    invoke-interface {v2}, Lorg/w3c/dom/Node;->getPrefix()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v0, v1, v2}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_constructQName(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljavax/xml/namespace/QName;

    move-result-object v0

    return-object v0
.end method

.method public getNamespaceContext()Ljavax/xml/namespace/NamespaceContext;
    .locals 0

    .line 622
    return-object p0
.end method

.method public getNamespaceCount()I
    .locals 4

    .line 628
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/4 v1, 0x2

    const/4 v2, 0x1

    if-eq v0, v2, :cond_0

    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    if-eq v0, v1, :cond_0

    .line 629
    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->reportWrongState(I)V

    .line 631
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_nsDeclList:Ljava/util/List;

    if-nez v0, :cond_3

    .line 632
    iget-boolean v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_cfgNsAware:Z

    const/4 v3, 0x0

    if-nez v0, :cond_1

    .line 633
    return v3

    .line 635
    :cond_1
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    if-ne v0, v2, :cond_2

    goto :goto_0

    :cond_2
    move v2, v3

    :goto_0
    invoke-direct {p0, v2}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_calcNsAndAttrLists(Z)V

    .line 637
    :cond_3
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_nsDeclList:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    div-int/2addr v0, v1

    return v0
.end method

.method public getNamespacePrefix(I)Ljava/lang/String;
    .locals 3
    .param p1, "index"    # I

    .line 647
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/4 v2, 0x2

    if-eq v0, v2, :cond_0

    .line 648
    invoke-virtual {p0, v2}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->reportWrongState(I)V

    .line 650
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_nsDeclList:Ljava/util/List;

    if-nez v0, :cond_3

    .line 651
    iget-boolean v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_cfgNsAware:Z

    if-nez v0, :cond_1

    .line 652
    invoke-direct {p0, p1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->handleIllegalNsIndex(I)V

    .line 654
    :cond_1
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    if-ne v0, v1, :cond_2

    goto :goto_0

    :cond_2
    const/4 v1, 0x0

    :goto_0
    invoke-direct {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_calcNsAndAttrLists(Z)V

    .line 656
    :cond_3
    if-ltz p1, :cond_4

    add-int v0, p1, p1

    iget-object v1, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_nsDeclList:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-lt v0, v1, :cond_5

    .line 657
    :cond_4
    invoke-direct {p0, p1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->handleIllegalNsIndex(I)V

    .line 660
    :cond_5
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_nsDeclList:Ljava/util/List;

    add-int v1, p1, p1

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    return-object v0
.end method

.method public getNamespaceURI()Ljava/lang/String;
    .locals 2

    .line 665
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/4 v1, 0x2

    if-eq v0, v1, :cond_0

    .line 666
    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->reportWrongState(I)V

    .line 668
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    invoke-interface {v0}, Lorg/w3c/dom/Node;->getNamespaceURI()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_internNsURI(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getNamespaceURI(I)Ljava/lang/String;
    .locals 3
    .param p1, "index"    # I

    .line 673
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/4 v2, 0x2

    if-eq v0, v2, :cond_0

    .line 674
    invoke-virtual {p0, v2}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->reportWrongState(I)V

    .line 676
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_nsDeclList:Ljava/util/List;

    if-nez v0, :cond_3

    .line 677
    iget-boolean v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_cfgNsAware:Z

    if-nez v0, :cond_1

    .line 678
    invoke-direct {p0, p1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->handleIllegalNsIndex(I)V

    .line 680
    :cond_1
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    if-ne v0, v1, :cond_2

    move v0, v1

    goto :goto_0

    :cond_2
    const/4 v0, 0x0

    :goto_0
    invoke-direct {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_calcNsAndAttrLists(Z)V

    .line 682
    :cond_3
    if-ltz p1, :cond_4

    add-int v0, p1, p1

    iget-object v2, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_nsDeclList:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    if-lt v0, v2, :cond_5

    .line 683
    :cond_4
    invoke-direct {p0, p1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->handleIllegalNsIndex(I)V

    .line 686
    :cond_5
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_nsDeclList:Ljava/util/List;

    add-int v2, p1, p1

    add-int/2addr v2, v1

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    return-object v0
.end method

.method public getNamespaceURI(Ljava/lang/String;)Ljava/lang/String;
    .locals 9
    .param p1, "prefix"    # Ljava/lang/String;

    .line 1100
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    .line 1101
    .local v0, "n":Lorg/w3c/dom/Node;
    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v1, 0x1

    .line 1103
    .local v1, "defaultNs":Z
    :goto_1
    if-eqz v0, :cond_6

    .line 1104
    invoke-interface {v0}, Lorg/w3c/dom/Node;->getAttributes()Lorg/w3c/dom/NamedNodeMap;

    move-result-object v2

    .line 1105
    .local v2, "attrs":Lorg/w3c/dom/NamedNodeMap;
    if-eqz v2, :cond_5

    .line 1106
    const/4 v3, 0x0

    .local v3, "i":I
    invoke-interface {v2}, Lorg/w3c/dom/NamedNodeMap;->getLength()I

    move-result v4

    .local v4, "len":I
    :goto_2
    if-ge v3, v4, :cond_5

    .line 1107
    invoke-interface {v2, v3}, Lorg/w3c/dom/NamedNodeMap;->item(I)Lorg/w3c/dom/Node;

    move-result-object v5

    .line 1108
    .local v5, "attr":Lorg/w3c/dom/Node;
    invoke-interface {v5}, Lorg/w3c/dom/Node;->getPrefix()Ljava/lang/String;

    move-result-object v6

    .line 1109
    .local v6, "thisPrefix":Ljava/lang/String;
    const-string v7, "xmlns"

    if-eqz v6, :cond_3

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v8

    if-nez v8, :cond_2

    goto :goto_3

    .line 1113
    :cond_2
    if-nez v1, :cond_4

    invoke-virtual {v7, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_4

    .line 1114
    invoke-interface {v5}, Lorg/w3c/dom/Node;->getLocalName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {p1, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_4

    .line 1115
    invoke-interface {v5}, Lorg/w3c/dom/Node;->getNodeValue()Ljava/lang/String;

    move-result-object v7

    return-object v7

    .line 1110
    :cond_3
    :goto_3
    if-eqz v1, :cond_4

    invoke-interface {v5}, Lorg/w3c/dom/Node;->getLocalName()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_4

    .line 1111
    invoke-interface {v5}, Lorg/w3c/dom/Node;->getNodeValue()Ljava/lang/String;

    move-result-object v7

    return-object v7

    .line 1106
    .end local v5    # "attr":Lorg/w3c/dom/Node;
    .end local v6    # "thisPrefix":Ljava/lang/String;
    :cond_4
    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    .line 1120
    .end local v3    # "i":I
    .end local v4    # "len":I
    :cond_5
    invoke-interface {v0}, Lorg/w3c/dom/Node;->getParentNode()Lorg/w3c/dom/Node;

    move-result-object v0

    .line 1121
    .end local v2    # "attrs":Lorg/w3c/dom/NamedNodeMap;
    goto :goto_1

    .line 1122
    :cond_6
    const/4 v2, 0x0

    return-object v2
.end method

.method public getNonTransientNamespaceContext()Ljavax/xml/namespace/NamespaceContext;
    .locals 1

    .line 1965
    invoke-static {}, Lorg/codehaus/stax2/ri/EmptyNamespaceContext;->getInstance()Lorg/codehaus/stax2/ri/EmptyNamespaceContext;

    move-result-object v0

    return-object v0
.end method

.method public getNotationAttributeIndex()I
    .locals 1

    .line 1870
    const/4 v0, -0x1

    return v0
.end method

.method public getPIData()Ljava/lang/String;
    .locals 2

    .line 694
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/4 v1, 0x3

    if-eq v0, v1, :cond_0

    .line 695
    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->reportWrongState(I)V

    .line 697
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    invoke-interface {v0}, Lorg/w3c/dom/Node;->getNodeValue()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getPITarget()Ljava/lang/String;
    .locals 2

    .line 702
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/4 v1, 0x3

    if-eq v0, v1, :cond_0

    .line 703
    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->reportWrongState(I)V

    .line 705
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    invoke-interface {v0}, Lorg/w3c/dom/Node;->getNodeName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_internName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getPrefix()Ljava/lang/String;
    .locals 2

    .line 710
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/4 v1, 0x2

    if-eq v0, v1, :cond_0

    .line 711
    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->reportWrongState(I)V

    .line 713
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    invoke-interface {v0}, Lorg/w3c/dom/Node;->getPrefix()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_internName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getPrefix(Ljava/lang/String;)Ljava/lang/String;
    .locals 8
    .param p1, "namespaceURI"    # Ljava/lang/String;

    .line 1142
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    .line 1143
    .local v0, "n":Lorg/w3c/dom/Node;
    if-nez p1, :cond_0

    .line 1144
    const-string p1, ""

    .line 1147
    :cond_0
    :goto_0
    if-eqz v0, :cond_5

    .line 1148
    invoke-interface {v0}, Lorg/w3c/dom/Node;->getAttributes()Lorg/w3c/dom/NamedNodeMap;

    move-result-object v1

    .line 1149
    .local v1, "attrs":Lorg/w3c/dom/NamedNodeMap;
    const/4 v2, 0x0

    .local v2, "i":I
    invoke-interface {v1}, Lorg/w3c/dom/NamedNodeMap;->getLength()I

    move-result v3

    .local v3, "len":I
    :goto_1
    if-ge v2, v3, :cond_4

    .line 1150
    invoke-interface {v1, v2}, Lorg/w3c/dom/NamedNodeMap;->item(I)Lorg/w3c/dom/Node;

    move-result-object v4

    .line 1151
    .local v4, "attr":Lorg/w3c/dom/Node;
    invoke-interface {v4}, Lorg/w3c/dom/Node;->getPrefix()Ljava/lang/String;

    move-result-object v5

    .line 1152
    .local v5, "thisPrefix":Ljava/lang/String;
    const-string v6, "xmlns"

    if-eqz v5, :cond_2

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v7

    if-nez v7, :cond_1

    goto :goto_2

    .line 1156
    :cond_1
    invoke-virtual {v6, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_3

    .line 1157
    invoke-interface {v4}, Lorg/w3c/dom/Node;->getNodeValue()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_3

    .line 1158
    invoke-interface {v4}, Lorg/w3c/dom/Node;->getLocalName()Ljava/lang/String;

    move-result-object v6

    return-object v6

    .line 1153
    :cond_2
    :goto_2
    invoke-interface {v4}, Lorg/w3c/dom/Node;->getLocalName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_3

    invoke-interface {v4}, Lorg/w3c/dom/Node;->getNodeValue()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_3

    .line 1154
    const-string v6, ""

    return-object v6

    .line 1149
    .end local v4    # "attr":Lorg/w3c/dom/Node;
    .end local v5    # "thisPrefix":Ljava/lang/String;
    :cond_3
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 1162
    .end local v2    # "i":I
    .end local v3    # "len":I
    :cond_4
    invoke-interface {v0}, Lorg/w3c/dom/Node;->getParentNode()Lorg/w3c/dom/Node;

    move-result-object v0

    .line 1163
    .end local v1    # "attrs":Lorg/w3c/dom/NamedNodeMap;
    goto :goto_0

    .line 1164
    :cond_5
    const/4 v1, 0x0

    return-object v1
.end method

.method public getPrefixedName()Ljava/lang/String;
    .locals 5

    .line 1971
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    sparse-switch v0, :sswitch_data_0

    .line 1995
    new-instance v0, Ljava/lang/IllegalStateException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Current state ("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    invoke-static {v2}, Lorg/codehaus/stax2/ri/Stax2Util;->eventTypeDesc(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ") not START_ELEMENT, END_ELEMENT, ENTITY_REFERENCE, PROCESSING_INSTRUCTION or DTD"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1992
    :sswitch_0
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getDTDRootName()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 1988
    :sswitch_1
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getLocalName()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 1990
    :sswitch_2
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getPITarget()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 1975
    :sswitch_3
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    invoke-interface {v0}, Lorg/w3c/dom/Node;->getPrefix()Ljava/lang/String;

    move-result-object v0

    .line 1976
    .local v0, "prefix":Ljava/lang/String;
    iget-object v1, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    invoke-direct {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_safeGetLocalName(Lorg/w3c/dom/Node;)Ljava/lang/String;

    move-result-object v1

    .line 1978
    .local v1, "ln":Ljava/lang/String;
    if-nez v0, :cond_0

    .line 1979
    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_internName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    return-object v2

    .line 1981
    :cond_0
    new-instance v2, Ljava/lang/StringBuffer;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v3

    add-int/lit8 v3, v3, 0x1

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v4

    add-int/2addr v3, v4

    invoke-direct {v2, v3}, Ljava/lang/StringBuffer;-><init>(I)V

    .line 1982
    .local v2, "sb":Ljava/lang/StringBuffer;
    invoke-virtual {v2, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 1983
    const/16 v3, 0x3a

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 1984
    invoke-virtual {v2, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 1985
    invoke-virtual {v2}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v3}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_internName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    return-object v3

    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_3
        0x2 -> :sswitch_3
        0x3 -> :sswitch_2
        0x9 -> :sswitch_1
        0xb -> :sswitch_0
    .end sparse-switch
.end method

.method public getPrefixes(Ljava/lang/String;)Ljava/util/Iterator;
    .locals 2
    .param p1, "namespaceURI"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/Iterator<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 1170
    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getPrefix(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1171
    .local v0, "prefix":Ljava/lang/String;
    if-nez v0, :cond_0

    .line 1172
    invoke-static {}, Lorg/codehaus/stax2/ri/EmptyIterator;->getInstance()Ljava/util/Iterator;

    move-result-object v1

    return-object v1

    .line 1174
    :cond_0
    invoke-static {v0}, Lorg/codehaus/stax2/ri/SingletonIterator;->create(Ljava/lang/Object;)Lorg/codehaus/stax2/ri/SingletonIterator;

    move-result-object v1

    return-object v1
.end method

.method public getProcessedDTD()Ljava/lang/Object;
    .locals 1

    .line 2012
    const/4 v0, 0x0

    return-object v0
.end method

.method public getProcessedDTDSchema()Lorg/codehaus/stax2/validation/DTDValidationSchema;
    .locals 1

    .line 2056
    const/4 v0, 0x0

    return-object v0
.end method

.method public abstract getProperty(Ljava/lang/String;)Ljava/lang/Object;
.end method

.method public getStartLocation()Lorg/codehaus/stax2/XMLStreamLocation2;
    .locals 1

    .line 2098
    sget-object v0, Lorg/codehaus/stax2/XMLStreamLocation2;->NOT_AVAILABLE:Lorg/codehaus/stax2/XMLStreamLocation2;

    return-object v0
.end method

.method public getStartingByteOffset()J
    .locals 2

    .line 2070
    const-wide/16 v0, -0x1

    return-wide v0
.end method

.method public getStartingCharOffset()J
    .locals 2

    .line 2076
    const-wide/16 v0, 0x0

    return-wide v0
.end method

.method public getText(Ljava/io/Writer;Z)I
    .locals 2
    .param p1, "w"    # Ljava/io/Writer;
    .param p2, "preserveContents"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1929
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getText()Ljava/lang/String;

    move-result-object v0

    .line 1930
    .local v0, "text":Ljava/lang/String;
    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 1931
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    return v1
.end method

.method public getText()Ljava/lang/String;
    .locals 2

    .line 719
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_coalescedText:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 720
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_coalescedText:Ljava/lang/String;

    return-object v0

    .line 722
    :cond_0
    const/4 v0, 0x1

    iget v1, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    shl-int/2addr v0, v1

    and-int/lit16 v0, v0, 0x1a70

    if-nez v0, :cond_1

    .line 723
    const/4 v0, 0x4

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->reportWrongState(I)V

    .line 725
    :cond_1
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    invoke-interface {v0}, Lorg/w3c/dom/Node;->getNodeValue()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getTextCharacters(I[CII)I
    .locals 2
    .param p1, "sourceStart"    # I
    .param p2, "target"    # [C
    .param p3, "targetStart"    # I
    .param p4, "len"    # I

    .line 738
    const/4 v0, 0x1

    iget v1, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    shl-int/2addr v0, v1

    and-int/lit16 v0, v0, 0x1070

    if-nez v0, :cond_0

    .line 739
    const/4 v0, 0x5

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->reportWrongState(I)V

    .line 741
    :cond_0
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getText()Ljava/lang/String;

    move-result-object v0

    .line 742
    .local v0, "text":Ljava/lang/String;
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-le p4, v1, :cond_1

    .line 743
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result p4

    .line 745
    :cond_1
    add-int v1, p1, p4

    invoke-virtual {v0, p1, v1, p2, p3}, Ljava/lang/String;->getChars(II[CI)V

    .line 746
    return p4
.end method

.method public getTextCharacters()[C
    .locals 2

    .line 731
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getText()Ljava/lang/String;

    move-result-object v0

    .line 732
    .local v0, "text":Ljava/lang/String;
    invoke-virtual {v0}, Ljava/lang/String;->toCharArray()[C

    move-result-object v1

    return-object v1
.end method

.method public getTextLength()I
    .locals 2

    .line 752
    const/4 v0, 0x1

    iget v1, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    shl-int/2addr v0, v1

    and-int/lit16 v0, v0, 0x1070

    if-nez v0, :cond_0

    .line 753
    const/4 v0, 0x5

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->reportWrongState(I)V

    .line 755
    :cond_0
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getText()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    return v0
.end method

.method public getTextStart()I
    .locals 2

    .line 761
    const/4 v0, 0x1

    iget v1, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    shl-int/2addr v0, v1

    and-int/lit16 v0, v0, 0x1070

    if-nez v0, :cond_0

    .line 762
    const/4 v0, 0x5

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->reportWrongState(I)V

    .line 764
    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public getVersion()Ljava/lang/String;
    .locals 1

    .line 324
    const/4 v0, 0x0

    return-object v0
.end method

.method public hasName()Z
    .locals 3

    .line 769
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_1

    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/4 v2, 0x2

    if-ne v0, v2, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :cond_1
    :goto_0
    return v1
.end method

.method public hasNext()Z
    .locals 2

    .line 774
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/16 v1, 0x8

    if-eq v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public hasText()Z
    .locals 2

    .line 779
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/4 v1, 0x1

    shl-int v0, v1, v0

    and-int/lit16 v0, v0, 0x1a70

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    return v1
.end method

.method public isAttributeSpecified(I)Z
    .locals 3
    .param p1, "index"    # I

    .line 785
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    .line 786
    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->reportWrongState(I)V

    .line 788
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    check-cast v0, Lorg/w3c/dom/Element;

    .line 789
    .local v0, "elem":Lorg/w3c/dom/Element;
    invoke-interface {v0}, Lorg/w3c/dom/Element;->getAttributes()Lorg/w3c/dom/NamedNodeMap;

    move-result-object v1

    invoke-interface {v1, p1}, Lorg/w3c/dom/NamedNodeMap;->item(I)Lorg/w3c/dom/Node;

    move-result-object v1

    check-cast v1, Lorg/w3c/dom/Attr;

    .line 790
    .local v1, "attr":Lorg/w3c/dom/Attr;
    if-nez v1, :cond_1

    .line 791
    invoke-direct {p0, p1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->handleIllegalAttrIndex(I)V

    .line 792
    const/4 v2, 0x0

    return v2

    .line 794
    :cond_1
    invoke-interface {v1}, Lorg/w3c/dom/Attr;->getSpecified()Z

    move-result v2

    return v2
.end method

.method public isCharacters()Z
    .locals 2

    .line 800
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/4 v1, 0x4

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public isEmptyElement()Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1954
    const/4 v0, 0x0

    return v0
.end method

.method public isEndElement()Z
    .locals 2

    .line 805
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public abstract isPropertySupported(Ljava/lang/String;)Z
.end method

.method public isStandalone()Z
    .locals 1

    .line 331
    const/4 v0, 0x0

    return v0
.end method

.method public isStartElement()Z
    .locals 2

    .line 810
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    return v1
.end method

.method public isWhiteSpace()Z
    .locals 7

    .line 816
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/4 v1, 0x4

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-eq v0, v1, :cond_2

    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/16 v1, 0xc

    if-ne v0, v1, :cond_0

    goto :goto_0

    .line 828
    :cond_0
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/4 v1, 0x6

    if-ne v0, v1, :cond_1

    move v2, v3

    :cond_1
    return v2

    .line 817
    :cond_2
    :goto_0
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getText()Ljava/lang/String;

    move-result-object v0

    .line 818
    .local v0, "text":Ljava/lang/String;
    const/4 v1, 0x0

    .local v1, "i":I
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v4

    .local v4, "len":I
    :goto_1
    if-ge v1, v4, :cond_4

    .line 822
    invoke-virtual {v0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v5

    const/16 v6, 0x20

    if-le v5, v6, :cond_3

    .line 823
    return v2

    .line 818
    :cond_3
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 826
    .end local v1    # "i":I
    .end local v4    # "len":I
    :cond_4
    return v3
.end method

.method public next()I
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 895
    const/4 v0, 0x0

    iput-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_coalescedText:Ljava/lang/String;

    .line 901
    iget v1, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/16 v2, 0xb

    const/16 v3, 0x9

    const/4 v4, 0x2

    const-string v5, "\'"

    const/16 v6, 0x8

    const/4 v7, 0x1

    sparse-switch v1, :sswitch_data_0

    goto/16 :goto_0

    .line 928
    :sswitch_0
    new-instance v0, Ljava/util/NoSuchElementException;

    const-string v1, "Can not call next() after receiving END_DOCUMENT"

    invoke-direct {v0, v1}, Ljava/util/NoSuchElementException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 907
    :sswitch_1
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    invoke-interface {v0}, Lorg/w3c/dom/Node;->getNodeType()S

    move-result v0

    sparse-switch v0, :sswitch_data_1

    .line 923
    new-instance v0, Ljavax/xml/stream/XMLStreamException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Internal error: unexpected DOM root node type "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    invoke-interface {v2}, Lorg/w3c/dom/Node;->getNodeType()S

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " for node \'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 911
    :sswitch_2
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    invoke-interface {v0}, Lorg/w3c/dom/Node;->getFirstChild()Lorg/w3c/dom/Node;

    move-result-object v0

    iput-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    .line 913
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    if-nez v0, :cond_2

    .line 914
    iput v6, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    return v6

    .line 920
    :sswitch_3
    iput v7, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    return v7

    .line 952
    :sswitch_4
    iget v1, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_depth:I

    sub-int/2addr v1, v7

    iput v1, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_depth:I

    .line 954
    iput-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_attrList:Ljava/util/List;

    .line 955
    iput-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_nsDeclList:Ljava/util/List;

    .line 962
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    iget-object v1, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_rootNode:Lorg/w3c/dom/Node;

    if-ne v0, v1, :cond_1

    .line 963
    iput v6, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    return v6

    .line 931
    :sswitch_5
    iget v1, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_depth:I

    add-int/2addr v1, v7

    iput v1, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_depth:I

    .line 932
    iput-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_attrList:Ljava/util/List;

    .line 934
    iget-object v1, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    invoke-interface {v1}, Lorg/w3c/dom/Node;->getFirstChild()Lorg/w3c/dom/Node;

    move-result-object v1

    .line 935
    .local v1, "firstChild":Lorg/w3c/dom/Node;
    if-nez v1, :cond_0

    .line 939
    iput v4, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    return v4

    .line 941
    :cond_0
    iput-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_nsDeclList:Ljava/util/List;

    .line 946
    iput-object v1, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    .line 947
    goto :goto_1

    .line 972
    .end local v1    # "firstChild":Lorg/w3c/dom/Node;
    :cond_1
    :goto_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    invoke-interface {v0}, Lorg/w3c/dom/Node;->getNextSibling()Lorg/w3c/dom/Node;

    move-result-object v0

    .line 974
    .local v0, "next":Lorg/w3c/dom/Node;
    if-eqz v0, :cond_5

    .line 975
    iput-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    .line 976
    nop

    .line 997
    .end local v0    # "next":Lorg/w3c/dom/Node;
    :cond_2
    :goto_1
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    invoke-interface {v0}, Lorg/w3c/dom/Node;->getNodeType()S

    move-result v0

    packed-switch v0, :pswitch_data_0

    .line 1035
    :pswitch_0
    new-instance v0, Ljavax/xml/stream/XMLStreamException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Internal error: unrecognized DOM node type "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    invoke-interface {v2}, Lorg/w3c/dom/Node;->getNodeType()S

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", for node \'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1009
    :pswitch_1
    iput v2, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    .line 1010
    goto :goto_2

    .line 1006
    :pswitch_2
    const/4 v0, 0x5

    iput v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    .line 1007
    goto :goto_2

    .line 1018
    :pswitch_3
    const/4 v0, 0x3

    iput v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    .line 1019
    goto :goto_2

    .line 1015
    :pswitch_4
    iput v3, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    .line 1016
    goto :goto_2

    .line 999
    :pswitch_5
    iget-boolean v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_coalescing:Z

    const/16 v1, 0xc

    if-eqz v0, :cond_3

    .line 1000
    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->coalesceText(I)V

    goto :goto_2

    .line 1002
    :cond_3
    iput v1, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    .line 1004
    goto :goto_2

    .line 1021
    :pswitch_6
    iget-boolean v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_coalescing:Z

    const/4 v1, 0x4

    if-eqz v0, :cond_4

    .line 1022
    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->coalesceText(I)V

    goto :goto_2

    .line 1024
    :cond_4
    iput v1, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    .line 1026
    goto :goto_2

    .line 1032
    :pswitch_7
    new-instance v0, Ljavax/xml/stream/XMLStreamException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Internal error: unexpected DOM node type "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    invoke-interface {v2}, Lorg/w3c/dom/Node;->getNodeType()S

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " (attr/entity/notation?), for node \'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1012
    :pswitch_8
    iput v7, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    .line 1013
    nop

    .line 1038
    :goto_2
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    return v0

    .line 982
    .restart local v0    # "next":Lorg/w3c/dom/Node;
    :cond_5
    iget-object v1, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    invoke-interface {v1}, Lorg/w3c/dom/Node;->getParentNode()Lorg/w3c/dom/Node;

    move-result-object v1

    iput-object v1, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    .line 983
    iget-object v1, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    invoke-interface {v1}, Lorg/w3c/dom/Node;->getNodeType()S

    move-result v1

    .line 984
    .local v1, "type":I
    if-ne v1, v7, :cond_6

    .line 985
    iput v4, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    return v4

    .line 988
    :cond_6
    iget-object v4, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    iget-object v5, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_rootNode:Lorg/w3c/dom/Node;

    if-ne v4, v5, :cond_8

    if-eq v1, v3, :cond_7

    if-ne v1, v2, :cond_8

    .line 992
    :cond_7
    iput v6, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    return v6

    .line 990
    :cond_8
    new-instance v2, Ljavax/xml/stream/XMLStreamException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Internal error: non-element parent node ("

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ") that is not the initial root node"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;)V

    throw v2

    nop

    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_5
        0x2 -> :sswitch_4
        0x7 -> :sswitch_1
        0x8 -> :sswitch_0
    .end sparse-switch

    :sswitch_data_1
    .sparse-switch
        0x1 -> :sswitch_3
        0x9 -> :sswitch_2
        0xb -> :sswitch_2
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_7
        :pswitch_3
        :pswitch_2
        :pswitch_0
        :pswitch_1
        :pswitch_0
        :pswitch_7
    .end packed-switch
.end method

.method public nextTag()I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1045
    nop

    :goto_0
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->next()I

    move-result v0

    .line 1047
    .local v0, "next":I
    packed-switch v0, :pswitch_data_0

    :pswitch_0
    goto :goto_1

    .line 1054
    :pswitch_1
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->isWhiteSpace()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1055
    goto :goto_0

    .line 1057
    :cond_0
    const-string v1, "Received non-all-whitespace CHARACTERS or CDATA event in nextTag()."

    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->throwStreamException(Ljava/lang/String;)V

    .line 1058
    goto :goto_1

    .line 1051
    :pswitch_2
    goto :goto_0

    .line 1061
    :pswitch_3
    return v0

    .line 1063
    :goto_1
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Received event "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {v0}, Lorg/codehaus/stax2/ri/Stax2Util;->eventTypeDesc(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", instead of START_ELEMENT or END_ELEMENT."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->throwStreamException(Ljava/lang/String;)V

    .line 1065
    .end local v0    # "next":I
    goto :goto_0

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_3
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_2
        :pswitch_2
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method public readElementAsArray(Lorg/codehaus/stax2/typed/TypedArrayDecoder;)I
    .locals 12
    .param p1, "tad"    # Lorg/codehaus/stax2/typed/TypedArrayDecoder;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1320
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/4 v1, 0x4

    const/4 v2, -0x1

    const/4 v3, 0x2

    const/4 v4, 0x1

    if-ne v0, v4, :cond_1

    .line 1322
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    invoke-interface {v0}, Lorg/w3c/dom/Node;->getFirstChild()Lorg/w3c/dom/Node;

    move-result-object v0

    .line 1323
    .local v0, "fc":Lorg/w3c/dom/Node;
    if-nez v0, :cond_0

    .line 1324
    iput v3, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    .line 1325
    return v2

    .line 1327
    :cond_0
    invoke-direct {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->coalesceTypedText(Lorg/w3c/dom/Node;)Ljava/lang/String;

    move-result-object v5

    iput-object v5, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_coalescedText:Ljava/lang/String;

    .line 1328
    iput v1, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    .line 1329
    iget-object v1, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    invoke-interface {v1}, Lorg/w3c/dom/Node;->getLastChild()Lorg/w3c/dom/Node;

    move-result-object v1

    iput-object v1, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    .line 1330
    .end local v0    # "fc":Lorg/w3c/dom/Node;
    goto :goto_0

    .line 1331
    :cond_1
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    if-eq v0, v1, :cond_3

    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/16 v1, 0xc

    if-eq v0, v1, :cond_3

    .line 1333
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    if-ne v0, v3, :cond_2

    .line 1334
    return v2

    .line 1336
    :cond_2
    const/4 v0, 0x6

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->reportWrongState(I)V

    .line 1344
    :cond_3
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_coalescedText:Ljava/lang/String;

    if-eqz v0, :cond_c

    .line 1352
    :goto_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_coalescedText:Ljava/lang/String;

    .line 1353
    .local v0, "input":Ljava/lang/String;
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    .line 1354
    .local v1, "end":I
    const/4 v5, 0x0

    .line 1355
    .local v5, "ptr":I
    const/4 v6, 0x0

    .line 1356
    .local v6, "count":I
    const/4 v7, 0x0

    .line 1360
    .local v7, "value":Ljava/lang/String;
    :goto_1
    const-string v8, ""

    if-ge v5, v1, :cond_9

    .line 1362
    :cond_4
    :try_start_0
    invoke-virtual {v0, v5}, Ljava/lang/String;->charAt(I)C

    move-result v9

    const/16 v10, 0x20

    if-gt v9, v10, :cond_5

    .line 1363
    add-int/lit8 v5, v5, 0x1

    if-lt v5, v1, :cond_4

    .line 1364
    goto :goto_5

    .line 1368
    :cond_5
    move v9, v5

    .line 1369
    .local v9, "start":I
    add-int/lit8 v5, v5, 0x1

    .line 1370
    :goto_2
    if-ge v5, v1, :cond_6

    invoke-virtual {v0, v5}, Ljava/lang/String;->charAt(I)C

    move-result v11

    if-le v11, v10, :cond_6

    .line 1371
    add-int/lit8 v5, v5, 0x1

    goto :goto_2

    .line 1373
    :cond_6
    add-int/lit8 v6, v6, 0x1

    .line 1375
    invoke-virtual {v0, v9, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v10

    move-object v7, v10

    .line 1377
    add-int/lit8 v5, v5, 0x1

    .line 1378
    invoke-virtual {p1, v7}, Lorg/codehaus/stax2/typed/TypedArrayDecoder;->decodeValue(Ljava/lang/String;)Z

    move-result v10
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v10, :cond_7

    .line 1379
    goto :goto_5

    .line 1381
    .end local v9    # "start":I
    :cond_7
    goto :goto_1

    .line 1390
    :catchall_0
    move-exception v2

    goto :goto_3

    .line 1382
    :catch_0
    move-exception v2

    .line 1387
    .local v2, "iae":Ljava/lang/IllegalArgumentException;
    :try_start_1
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getLocation()Ljavax/xml/stream/Location;

    move-result-object v3

    .line 1388
    .local v3, "loc":Ljavax/xml/stream/Location;
    new-instance v9, Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    invoke-virtual {v2}, Ljava/lang/IllegalArgumentException;->getMessage()Ljava/lang/String;

    move-result-object v10

    invoke-direct {v9, v7, v10, v3, v2}, Lorg/codehaus/stax2/typed/TypedXMLStreamException;-><init>(Ljava/lang/String;Ljava/lang/String;Ljavax/xml/stream/Location;Ljava/lang/IllegalArgumentException;)V

    .end local v0    # "input":Ljava/lang/String;
    .end local v1    # "end":I
    .end local v5    # "ptr":I
    .end local v6    # "count":I
    .end local v7    # "value":Ljava/lang/String;
    .end local p1    # "tad":Lorg/codehaus/stax2/typed/TypedArrayDecoder;
    throw v9
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1390
    .end local v2    # "iae":Ljava/lang/IllegalArgumentException;
    .end local v3    # "loc":Ljavax/xml/stream/Location;
    .restart local v0    # "input":Ljava/lang/String;
    .restart local v1    # "end":I
    .restart local v5    # "ptr":I
    .restart local v6    # "count":I
    .restart local v7    # "value":Ljava/lang/String;
    .restart local p1    # "tad":Lorg/codehaus/stax2/typed/TypedArrayDecoder;
    :goto_3
    sub-int v3, v1, v5

    .line 1391
    .local v3, "len":I
    if-ge v3, v4, :cond_8

    goto :goto_4

    :cond_8
    invoke-virtual {v0, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v8

    :goto_4
    iput-object v8, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_coalescedText:Ljava/lang/String;

    .line 1392
    .end local v3    # "len":I
    throw v2

    .line 1390
    :cond_9
    :goto_5
    sub-int v9, v1, v5

    .line 1391
    .local v9, "len":I
    if-ge v9, v4, :cond_a

    goto :goto_6

    :cond_a
    invoke-virtual {v0, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v8

    :goto_6
    iput-object v8, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_coalescedText:Ljava/lang/String;

    .line 1392
    .end local v9    # "len":I
    nop

    .line 1394
    if-ge v6, v4, :cond_b

    .line 1395
    iput v3, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    .line 1396
    iget-object v3, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    invoke-interface {v3}, Lorg/w3c/dom/Node;->getParentNode()Lorg/w3c/dom/Node;

    move-result-object v3

    iput-object v3, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currNode:Lorg/w3c/dom/Node;

    .line 1397
    return v2

    .line 1399
    :cond_b
    return v6

    .line 1345
    .end local v0    # "input":Ljava/lang/String;
    .end local v1    # "end":I
    .end local v5    # "ptr":I
    .end local v6    # "count":I
    .end local v7    # "value":Ljava/lang/String;
    :cond_c
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "First call to readElementAsArray() must be for a START_ELEMENT, not directly for a textual event"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public readElementAsBinary([BII)I
    .locals 1
    .param p1, "resultBuffer"    # [B
    .param p2, "offset"    # I
    .param p3, "maxLength"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1444
    invoke-static {}, Lorg/codehaus/stax2/typed/Base64Variants;->getDefaultVariant()Lorg/codehaus/stax2/typed/Base64Variant;

    move-result-object v0

    invoke-virtual {p0, p1, p2, p3, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->readElementAsBinary([BIILorg/codehaus/stax2/typed/Base64Variant;)I

    move-result v0

    return v0
.end method

.method public readElementAsBinary([BIILorg/codehaus/stax2/typed/Base64Variant;)I
    .locals 18
    .param p1, "resultBuffer"    # [B
    .param p2, "offset"    # I
    .param p3, "maxLength"    # I
    .param p4, "v"    # Lorg/codehaus/stax2/typed/Base64Variant;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1452
    move-object/from16 v1, p0

    move-object/from16 v2, p1

    move/from16 v0, p2

    move/from16 v3, p3

    move-object/from16 v4, p4

    const-string v5, ""

    if-eqz v2, :cond_13

    .line 1455
    if-ltz v0, :cond_12

    .line 1458
    const/4 v7, 0x1

    if-lt v3, v7, :cond_10

    add-int v8, v0, v3

    array-length v9, v2

    if-le v8, v9, :cond_0

    goto/16 :goto_9

    .line 1465
    :cond_0
    invoke-virtual/range {p0 .. p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_base64Decoder()Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;

    move-result-object v8

    .line 1466
    .local v8, "dec":Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;
    iget v9, v1, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    .line 1468
    .local v9, "type":I
    shl-int v10, v7, v9

    and-int/lit16 v10, v10, 0x1052

    const/4 v11, 0x6

    const/4 v12, -0x1

    const/4 v13, 0x2

    if-nez v10, :cond_2

    .line 1469
    if-ne v9, v13, :cond_1

    .line 1471
    invoke-virtual {v8}, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->hasData()Z

    move-result v10

    if-nez v10, :cond_2

    .line 1472
    return v12

    .line 1475
    :cond_1
    invoke-virtual {v1, v11}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->reportWrongState(I)V

    .line 1480
    :cond_2
    const/4 v10, 0x4

    const/4 v14, 0x3

    const/4 v15, 0x5

    if-ne v9, v7, :cond_7

    .line 1483
    :goto_0
    invoke-virtual/range {p0 .. p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->next()I

    move-result v9

    .line 1484
    if-ne v9, v13, :cond_3

    .line 1486
    return v12

    .line 1488
    :cond_3
    if-eq v9, v15, :cond_6

    if-ne v9, v14, :cond_4

    .line 1489
    goto :goto_1

    .line 1491
    :cond_4
    shl-int v12, v7, v9

    and-int/lit16 v12, v12, 0x1250

    if-nez v12, :cond_5

    .line 1492
    invoke-virtual {v1, v10}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->reportParseProblem(I)V

    .line 1494
    :cond_5
    invoke-virtual/range {p0 .. p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getText()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v8, v4, v7, v12}, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->init(Lorg/codehaus/stax2/typed/Base64Variant;ZLjava/lang/String;)V

    .line 1495
    goto :goto_2

    .line 1483
    :cond_6
    :goto_1
    const/4 v12, -0x1

    goto :goto_0

    .line 1499
    :cond_7
    :goto_2
    const/4 v12, 0x0

    move/from16 v17, v12

    move v12, v9

    move v9, v3

    move v3, v0

    .line 1506
    .end local p2    # "offset":I
    .end local p3    # "maxLength":I
    .local v3, "offset":I
    .local v9, "maxLength":I
    .local v12, "type":I
    .local v17, "totalCount":I
    :goto_3
    :try_start_0
    invoke-virtual {v8, v2, v3, v9}, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->decode([BII)I

    move-result v0
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1509
    .local v0, "count":I
    nop

    .line 1510
    add-int/2addr v3, v0

    .line 1511
    add-int v17, v17, v0

    .line 1512
    sub-int/2addr v9, v0

    .line 1517
    if-lt v9, v7, :cond_e

    iget v6, v1, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    if-ne v6, v13, :cond_8

    .line 1518
    goto :goto_7

    .line 1522
    :cond_8
    :goto_4
    invoke-virtual/range {p0 .. p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->next()I

    move-result v12

    .line 1523
    if-eq v12, v15, :cond_d

    if-eq v12, v14, :cond_d

    if-ne v12, v11, :cond_9

    .line 1525
    goto :goto_6

    .line 1527
    :cond_9
    if-ne v12, v13, :cond_b

    .line 1534
    invoke-virtual {v8}, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->endOfContent()I

    move-result v6

    .line 1535
    .local v6, "left":I
    if-ltz v6, :cond_a

    .line 1537
    if-lez v6, :cond_e

    .line 1538
    goto :goto_5

    .line 1536
    :cond_a
    const-string v7, "Incomplete base64 triplet at the end of decoded content"

    invoke-virtual {v1, v7, v5}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_constructTypeException(Ljava/lang/String;Ljava/lang/String;)Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    move-result-object v5

    throw v5

    .line 1543
    .end local v6    # "left":I
    :cond_b
    shl-int v6, v7, v12

    and-int/lit16 v6, v6, 0x1250

    if-nez v6, :cond_c

    .line 1544
    invoke-virtual {v1, v10}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->reportParseProblem(I)V

    .line 1546
    :cond_c
    invoke-virtual/range {p0 .. p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getText()Ljava/lang/String;

    move-result-object v6

    const/4 v7, 0x0

    invoke-virtual {v8, v4, v7, v6}, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->init(Lorg/codehaus/stax2/typed/Base64Variant;ZLjava/lang/String;)V

    .line 1547
    nop

    .line 1549
    .end local v0    # "count":I
    nop

    .line 1506
    :goto_5
    const/4 v7, 0x1

    goto :goto_3

    .line 1522
    .restart local v0    # "count":I
    :cond_d
    :goto_6
    const/4 v7, 0x1

    goto :goto_4

    .line 1552
    .end local v0    # "count":I
    :cond_e
    :goto_7
    if-lez v17, :cond_f

    move/from16 v16, v17

    goto :goto_8

    :cond_f
    const/16 v16, -0x1

    :goto_8
    return v16

    .line 1507
    :catch_0
    move-exception v0

    move-object v6, v0

    move-object v0, v6

    .line 1508
    .local v0, "iae":Ljava/lang/IllegalArgumentException;
    invoke-virtual {v1, v0, v5}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_constructTypeException(Ljava/lang/IllegalArgumentException;Ljava/lang/String;)Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    move-result-object v5

    throw v5

    .line 1459
    .end local v0    # "iae":Ljava/lang/IllegalArgumentException;
    .end local v3    # "offset":I
    .end local v8    # "dec":Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;
    .end local v9    # "maxLength":I
    .end local v12    # "type":I
    .end local v17    # "totalCount":I
    .restart local p2    # "offset":I
    .restart local p3    # "maxLength":I
    :cond_10
    :goto_9
    if-nez v3, :cond_11

    .line 1460
    const/4 v5, 0x0

    return v5

    .line 1462
    :cond_11
    new-instance v5, Ljava/lang/IllegalArgumentException;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Illegal maxLength ("

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "), has to be positive number, and offset+maxLength can not exceed"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    array-length v7, v2

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v5

    .line 1456
    :cond_12
    new-instance v5, Ljava/lang/IllegalArgumentException;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Illegal offset ("

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "), must be [0, "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    array-length v7, v2

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "["

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v5

    .line 1453
    :cond_13
    new-instance v5, Ljava/lang/IllegalArgumentException;

    const-string v6, "resultBuffer is null"

    invoke-direct {v5, v6}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v5
.end method

.method public readElementAsDoubleArray([DII)I
    .locals 1
    .param p1, "value"    # [D
    .param p2, "from"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1311
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getDoubleArrayDecoder([DII)Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->readElementAsArray(Lorg/codehaus/stax2/typed/TypedArrayDecoder;)I

    move-result v0

    return v0
.end method

.method public readElementAsFloatArray([FII)I
    .locals 1
    .param p1, "value"    # [F
    .param p2, "from"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1305
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getFloatArrayDecoder([FII)Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->readElementAsArray(Lorg/codehaus/stax2/typed/TypedArrayDecoder;)I

    move-result v0

    return v0
.end method

.method public readElementAsIntArray([III)I
    .locals 1
    .param p1, "value"    # [I
    .param p2, "from"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1293
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getIntArrayDecoder([III)Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->readElementAsArray(Lorg/codehaus/stax2/typed/TypedArrayDecoder;)I

    move-result v0

    return v0
.end method

.method public readElementAsLongArray([JII)I
    .locals 1
    .param p1, "value"    # [J
    .param p2, "from"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1299
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getLongArrayDecoder([JII)Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->readElementAsArray(Lorg/codehaus/stax2/typed/TypedArrayDecoder;)I

    move-result v0

    return v0
.end method

.method protected reportParseProblem(I)V
    .locals 1
    .param p1, "errorType"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2303
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->findErrorDesc(II)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->throwStreamException(Ljava/lang/String;)V

    .line 2304
    return-void
.end method

.method protected reportWrongState(I)V
    .locals 2
    .param p1, "errorType"    # I

    .line 2297
    new-instance v0, Ljava/lang/IllegalStateException;

    iget v1, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    invoke-virtual {p0, p1, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->findErrorDesc(II)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public require(ILjava/lang/String;Ljava/lang/String;)V
    .locals 8
    .param p1, "type"    # I
    .param p2, "nsUri"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 835
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    .line 841
    .local v0, "curr":I
    if-eq v0, p1, :cond_1

    .line 842
    const/16 v1, 0xc

    if-ne v0, v1, :cond_0

    .line 843
    const/4 v0, 0x4

    goto :goto_0

    .line 844
    :cond_0
    const/4 v1, 0x6

    if-ne v0, v1, :cond_1

    .line 845
    const/4 v0, 0x4

    .line 849
    :cond_1
    :goto_0
    if-eq p1, v0, :cond_2

    .line 850
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Required type "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {p1}, Lorg/codehaus/stax2/ri/Stax2Util;->eventTypeDesc(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", current type "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 852
    invoke-static {v0}, Lorg/codehaus/stax2/ri/Stax2Util;->eventTypeDesc(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 850
    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->throwStreamException(Ljava/lang/String;)V

    .line 855
    :cond_2
    const-string v1, ")"

    const/4 v2, 0x2

    const/4 v3, 0x1

    const-string v4, "\'."

    if-eqz p3, :cond_4

    .line 856
    if-eq v0, v3, :cond_3

    if-eq v0, v2, :cond_3

    const/16 v5, 0x9

    if-eq v0, v5, :cond_3

    .line 858
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Required a non-null local name, but current token not a START_ELEMENT, END_ELEMENT or ENTITY_REFERENCE (was "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget v6, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    invoke-static {v6}, Lorg/codehaus/stax2/ri/Stax2Util;->eventTypeDesc(I)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v5}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->throwStreamException(Ljava/lang/String;)V

    .line 860
    :cond_3
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getLocalName()Ljava/lang/String;

    move-result-object v5

    .line 861
    .local v5, "n":Ljava/lang/String;
    if-eq v5, p3, :cond_4

    invoke-virtual {v5, p3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_4

    .line 862
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Required local name \'"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "\'; current local name \'"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {p0, v6}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->throwStreamException(Ljava/lang/String;)V

    .line 865
    .end local v5    # "n":Ljava/lang/String;
    :cond_4
    if-eqz p2, :cond_7

    .line 866
    if-eq v0, v3, :cond_5

    if-eq v0, v2, :cond_5

    .line 867
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Required non-null NS URI, but current token not a START_ELEMENT or END_ELEMENT (was "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {v0}, Lorg/codehaus/stax2/ri/Stax2Util;->eventTypeDesc(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->throwStreamException(Ljava/lang/String;)V

    .line 870
    :cond_5
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getNamespaceURI()Ljava/lang/String;

    move-result-object v1

    .line 872
    .local v1, "uri":Ljava/lang/String;
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v2

    if-nez v2, :cond_6

    .line 873
    if-eqz v1, :cond_7

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-lez v2, :cond_7

    .line 874
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Required empty namespace, instead have \'"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->throwStreamException(Ljava/lang/String;)V

    goto :goto_1

    .line 877
    :cond_6
    if-eq p2, v1, :cond_7

    invoke-virtual {p2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_7

    .line 878
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Required namespace \'"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\'; have \'"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->throwStreamException(Ljava/lang/String;)V

    .line 884
    .end local v1    # "uri":Ljava/lang/String;
    :cond_7
    :goto_1
    return-void
.end method

.method public setFeature(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 3
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Object;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 1781
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unrecognized feature \""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method protected setInternNames(Z)V
    .locals 0
    .param p1, "state"    # Z

    .line 274
    iput-boolean p1, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_cfgInternNames:Z

    return-void
.end method

.method protected setInternNsURIs(Z)V
    .locals 0
    .param p1, "state"    # Z

    .line 275
    iput-boolean p1, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_cfgInternNsURIs:Z

    return-void
.end method

.method public abstract setProperty(Ljava/lang/String;Ljava/lang/Object;)Z
.end method

.method public setValidationProblemHandler(Lorg/codehaus/stax2/validation/ValidationProblemHandler;)Lorg/codehaus/stax2/validation/ValidationProblemHandler;
    .locals 1
    .param p1, "h"    # Lorg/codehaus/stax2/validation/ValidationProblemHandler;

    .line 2148
    const/4 v0, 0x0

    return-object v0
.end method

.method public skipElement()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1789
    iget v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->_currEvent:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    .line 1790
    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->reportWrongState(I)V

    .line 1792
    :cond_0
    const/4 v0, 0x1

    .line 1795
    .local v0, "nesting":I
    :goto_0
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->next()I

    move-result v2

    .line 1796
    .local v2, "type":I
    if-ne v2, v1, :cond_1

    .line 1797
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 1798
    :cond_1
    const/4 v3, 0x2

    if-ne v2, v3, :cond_2

    .line 1799
    add-int/lit8 v0, v0, -0x1

    if-nez v0, :cond_2

    .line 1800
    nop

    .line 1804
    .end local v2    # "type":I
    return-void

    .line 1803
    :cond_2
    :goto_1
    goto :goto_0
.end method

.method public standaloneSet()Z
    .locals 1

    .line 338
    const/4 v0, 0x0

    return v0
.end method

.method public stopValidatingAgainst(Lorg/codehaus/stax2/validation/XMLValidationSchema;)Lorg/codehaus/stax2/validation/XMLValidator;
    .locals 1
    .param p1, "schema"    # Lorg/codehaus/stax2/validation/XMLValidationSchema;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2133
    const/4 v0, 0x0

    return-object v0
.end method

.method public stopValidatingAgainst(Lorg/codehaus/stax2/validation/XMLValidator;)Lorg/codehaus/stax2/validation/XMLValidator;
    .locals 1
    .param p1, "validator"    # Lorg/codehaus/stax2/validation/XMLValidator;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2141
    const/4 v0, 0x0

    return-object v0
.end method

.method protected throwStreamException(Ljava/lang/String;)V
    .locals 1
    .param p1, "msg"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2309
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->getErrorLocation()Ljavax/xml/stream/Location;

    move-result-object v0

    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;->throwStreamException(Ljava/lang/String;Ljavax/xml/stream/Location;)V

    .line 2310
    return-void
.end method

.method protected abstract throwStreamException(Ljava/lang/String;Ljavax/xml/stream/Location;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public validateAgainst(Lorg/codehaus/stax2/validation/XMLValidationSchema;)Lorg/codehaus/stax2/validation/XMLValidator;
    .locals 1
    .param p1, "schema"    # Lorg/codehaus/stax2/validation/XMLValidationSchema;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2125
    const/4 v0, 0x0

    return-object v0
.end method
