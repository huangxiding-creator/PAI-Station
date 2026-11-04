.class abstract Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;
.super Lcom/fasterxml/jackson/databind/deser/std/StdDeserializer;
.source "JsonNodeDeserializer.java"

# interfaces
.implements Lcom/fasterxml/jackson/databind/deser/ContextualDeserializer;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer$ContainerStack;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Lcom/fasterxml/jackson/databind/JsonNode;",
        ">",
        "Lcom/fasterxml/jackson/databind/deser/std/StdDeserializer<",
        "TT;>;",
        "Lcom/fasterxml/jackson/databind/deser/ContextualDeserializer;"
    }
.end annotation


# instance fields
.field protected final _mergeArrays:Z

.field protected final _mergeObjects:Z

.field protected final _supportsUpdates:Ljava/lang/Boolean;


# direct methods
.method protected constructor <init>(Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;ZZ)V
    .locals 1
    .param p2, "mergeArrays"    # Z
    .param p3, "mergeObjects"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer<",
            "*>;ZZ)V"
        }
    .end annotation

    .line 264
    .local p0, "this":Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;, "Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer<TT;>;"
    .local p1, "base":Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;, "Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer<*>;"
    invoke-direct {p0, p1}, Lcom/fasterxml/jackson/databind/deser/std/StdDeserializer;-><init>(Lcom/fasterxml/jackson/databind/deser/std/StdDeserializer;)V

    .line 265
    iget-object v0, p1, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_supportsUpdates:Ljava/lang/Boolean;

    iput-object v0, p0, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_supportsUpdates:Ljava/lang/Boolean;

    .line 266
    iput-boolean p2, p0, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_mergeArrays:Z

    .line 267
    iput-boolean p3, p0, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_mergeObjects:Z

    .line 268
    return-void
.end method

.method public constructor <init>(Ljava/lang/Class;Ljava/lang/Boolean;)V
    .locals 1
    .param p2, "supportsUpdates"    # Ljava/lang/Boolean;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "TT;>;",
            "Ljava/lang/Boolean;",
            ")V"
        }
    .end annotation

    .line 255
    .local p0, "this":Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;, "Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer<TT;>;"
    .local p1, "vc":Ljava/lang/Class;, "Ljava/lang/Class<TT;>;"
    invoke-direct {p0, p1}, Lcom/fasterxml/jackson/databind/deser/std/StdDeserializer;-><init>(Ljava/lang/Class;)V

    .line 256
    iput-object p2, p0, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_supportsUpdates:Ljava/lang/Boolean;

    .line 257
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_mergeArrays:Z

    .line 258
    iput-boolean v0, p0, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_mergeObjects:Z

    .line 259
    return-void
.end method

.method private static _shouldMerge(Ljava/lang/Boolean;Ljava/lang/Boolean;)Z
    .locals 1
    .param p0, "specificMerge"    # Ljava/lang/Boolean;
    .param p1, "generalMerge"    # Ljava/lang/Boolean;

    .line 319
    if-eqz p0, :cond_0

    .line 320
    invoke-virtual {p0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    return v0

    .line 322
    :cond_0
    if-eqz p1, :cond_1

    .line 323
    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    return v0

    .line 325
    :cond_1
    const/4 v0, 0x1

    return v0
.end method


# virtual methods
.method protected abstract _createWithMerge(ZZ)Lcom/fasterxml/jackson/databind/JsonDeserializer;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(ZZ)",
            "Lcom/fasterxml/jackson/databind/JsonDeserializer<",
            "*>;"
        }
    .end annotation
.end method

.method protected final _deserializeAnyScalar(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;)Lcom/fasterxml/jackson/databind/JsonNode;
    .locals 2
    .param p1, "p"    # Lcom/fasterxml/jackson/core/JsonParser;
    .param p2, "ctxt"    # Lcom/fasterxml/jackson/databind/DeserializationContext;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 660
    .local p0, "this":Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;, "Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer<TT;>;"
    invoke-virtual {p2}, Lcom/fasterxml/jackson/databind/DeserializationContext;->getNodeFactory()Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;

    move-result-object v0

    .line 661
    .local v0, "nodeF":Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;
    invoke-virtual {p1}, Lcom/fasterxml/jackson/core/JsonParser;->currentTokenId()I

    move-result v1

    packed-switch v1, :pswitch_data_0

    .line 682
    :pswitch_0
    invoke-virtual {p0}, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->handledType()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {p2, v1, p1}, Lcom/fasterxml/jackson/databind/DeserializationContext;->handleUnexpectedToken(Ljava/lang/Class;Lcom/fasterxml/jackson/core/JsonParser;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/fasterxml/jackson/databind/JsonNode;

    return-object v1

    .line 677
    :pswitch_1
    invoke-virtual {p0, p1, p2}, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_fromEmbedded(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;)Lcom/fasterxml/jackson/databind/JsonNode;

    move-result-object v1

    return-object v1

    .line 675
    :pswitch_2
    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->nullNode()Lcom/fasterxml/jackson/databind/node/NullNode;

    move-result-object v1

    return-object v1

    .line 673
    :pswitch_3
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->booleanNode(Z)Lcom/fasterxml/jackson/databind/node/BooleanNode;

    move-result-object v1

    return-object v1

    .line 671
    :pswitch_4
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->booleanNode(Z)Lcom/fasterxml/jackson/databind/node/BooleanNode;

    move-result-object v1

    return-object v1

    .line 669
    :pswitch_5
    invoke-virtual {p0, p1, p2, v0}, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_fromFloat(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;)Lcom/fasterxml/jackson/databind/JsonNode;

    move-result-object v1

    return-object v1

    .line 667
    :pswitch_6
    invoke-virtual {p0, p1, p2, v0}, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_fromInt(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;)Lcom/fasterxml/jackson/databind/JsonNode;

    move-result-object v1

    return-object v1

    .line 665
    :pswitch_7
    invoke-virtual {p1}, Lcom/fasterxml/jackson/core/JsonParser;->getText()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->textNode(Ljava/lang/String;)Lcom/fasterxml/jackson/databind/node/TextNode;

    move-result-object v1

    return-object v1

    .line 663
    :pswitch_8
    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->objectNode()Lcom/fasterxml/jackson/databind/node/ObjectNode;

    move-result-object v1

    return-object v1

    :pswitch_data_0
    .packed-switch 0x2
        :pswitch_8
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method

.method protected final _deserializeContainerNoRecursion(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer$ContainerStack;Lcom/fasterxml/jackson/databind/node/ContainerNode;)Lcom/fasterxml/jackson/databind/node/ContainerNode;
    .locals 20
    .param p1, "p"    # Lcom/fasterxml/jackson/core/JsonParser;
    .param p2, "ctxt"    # Lcom/fasterxml/jackson/databind/DeserializationContext;
    .param p3, "nodeFactory"    # Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;
    .param p4, "stack"    # Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer$ContainerStack;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/fasterxml/jackson/core/JsonParser;",
            "Lcom/fasterxml/jackson/databind/DeserializationContext;",
            "Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;",
            "Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer$ContainerStack;",
            "Lcom/fasterxml/jackson/databind/node/ContainerNode<",
            "*>;)",
            "Lcom/fasterxml/jackson/databind/node/ContainerNode<",
            "*>;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 527
    .local p0, "this":Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;, "Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer<TT;>;"
    .local p5, "root":Lcom/fasterxml/jackson/databind/node/ContainerNode;, "Lcom/fasterxml/jackson/databind/node/ContainerNode<*>;"
    move-object/from16 v8, p0

    move-object/from16 v9, p1

    move-object/from16 v10, p3

    move-object/from16 v11, p4

    move-object/from16 v0, p5

    .line 528
    .local v0, "curr":Lcom/fasterxml/jackson/databind/node/ContainerNode;, "Lcom/fasterxml/jackson/databind/node/ContainerNode<*>;"
    invoke-virtual/range {p2 .. p2}, Lcom/fasterxml/jackson/databind/DeserializationContext;->getDeserializationFeatures()I

    move-result v1

    sget v2, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->F_MASK_INT_COERCIONS:I

    and-int v12, v1, v2

    .line 532
    .local v12, "intCoercionFeats":I
    :goto_0
    instance-of v1, v0, Lcom/fasterxml/jackson/databind/node/ObjectNode;

    const/4 v13, 0x0

    const/4 v14, 0x1

    if-eqz v1, :cond_6

    .line 533
    move-object v1, v0

    check-cast v1, Lcom/fasterxml/jackson/databind/node/ObjectNode;

    .line 534
    .local v1, "currObject":Lcom/fasterxml/jackson/databind/node/ObjectNode;
    invoke-virtual/range {p1 .. p1}, Lcom/fasterxml/jackson/core/JsonParser;->nextFieldName()Ljava/lang/String;

    move-result-object v2

    move-object v15, v0

    move-object v7, v1

    move-object v6, v2

    .line 537
    .end local v0    # "curr":Lcom/fasterxml/jackson/databind/node/ContainerNode;, "Lcom/fasterxml/jackson/databind/node/ContainerNode<*>;"
    .end local v1    # "currObject":Lcom/fasterxml/jackson/databind/node/ObjectNode;
    .local v6, "propName":Ljava/lang/String;
    .local v7, "currObject":Lcom/fasterxml/jackson/databind/node/ObjectNode;
    .local v15, "curr":Lcom/fasterxml/jackson/databind/node/ContainerNode;, "Lcom/fasterxml/jackson/databind/node/ContainerNode<*>;"
    :goto_1
    if-eqz v6, :cond_5

    .line 539
    invoke-virtual/range {p1 .. p1}, Lcom/fasterxml/jackson/core/JsonParser;->nextToken()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    .line 540
    .local v0, "t":Lcom/fasterxml/jackson/core/JsonToken;
    if-nez v0, :cond_0

    .line 541
    sget-object v0, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    move-object/from16 v16, v0

    goto :goto_2

    .line 540
    :cond_0
    move-object/from16 v16, v0

    .line 543
    .end local v0    # "t":Lcom/fasterxml/jackson/core/JsonToken;
    .local v16, "t":Lcom/fasterxml/jackson/core/JsonToken;
    :goto_2
    invoke-virtual/range {v16 .. v16}, Lcom/fasterxml/jackson/core/JsonToken;->id()I

    move-result v0

    packed-switch v0, :pswitch_data_0

    .line 592
    :pswitch_0
    move-object v8, v6

    move-object v14, v7

    .end local v6    # "propName":Ljava/lang/String;
    .end local v7    # "currObject":Lcom/fasterxml/jackson/databind/node/ObjectNode;
    .local v8, "propName":Ljava/lang/String;
    .local v14, "currObject":Lcom/fasterxml/jackson/databind/node/ObjectNode;
    invoke-virtual/range {p0 .. p2}, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_deserializeRareScalar(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;)Lcom/fasterxml/jackson/databind/JsonNode;

    move-result-object v0

    move-object v7, v0

    .local v0, "value":Lcom/fasterxml/jackson/databind/JsonNode;
    goto/16 :goto_5

    .line 586
    .end local v0    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    .end local v8    # "propName":Ljava/lang/String;
    .end local v14    # "currObject":Lcom/fasterxml/jackson/databind/node/ObjectNode;
    .restart local v6    # "propName":Ljava/lang/String;
    .restart local v7    # "currObject":Lcom/fasterxml/jackson/databind/node/ObjectNode;
    :pswitch_1
    sget-object v0, Lcom/fasterxml/jackson/databind/cfg/JsonNodeFeature;->READ_NULL_PROPERTIES:Lcom/fasterxml/jackson/databind/cfg/JsonNodeFeature;

    move-object/from16 v5, p2

    invoke-virtual {v5, v0}, Lcom/fasterxml/jackson/databind/DeserializationContext;->isEnabled(Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 587
    move-object v8, v6

    move-object v14, v7

    goto/16 :goto_6

    .line 589
    :cond_1
    invoke-virtual/range {p3 .. p3}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->nullNode()Lcom/fasterxml/jackson/databind/node/NullNode;

    move-result-object v0

    .line 590
    .restart local v0    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    move-object v8, v6

    move-object v14, v7

    move-object v7, v0

    goto/16 :goto_5

    .line 582
    .end local v0    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    :pswitch_2
    move-object/from16 v5, p2

    invoke-virtual {v10, v13}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->booleanNode(Z)Lcom/fasterxml/jackson/databind/node/BooleanNode;

    move-result-object v0

    .line 583
    .restart local v0    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    move-object v8, v6

    move-object v14, v7

    move-object v7, v0

    goto/16 :goto_5

    .line 579
    .end local v0    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    :pswitch_3
    move-object/from16 v5, p2

    invoke-virtual {v10, v14}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->booleanNode(Z)Lcom/fasterxml/jackson/databind/node/BooleanNode;

    move-result-object v0

    .line 580
    .restart local v0    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    move-object v8, v6

    move-object v14, v7

    move-object v7, v0

    goto/16 :goto_5

    .line 576
    .end local v0    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    :pswitch_4
    move-object/from16 v5, p2

    invoke-virtual/range {p0 .. p3}, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_fromFloat(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;)Lcom/fasterxml/jackson/databind/JsonNode;

    move-result-object v0

    .line 577
    .restart local v0    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    move-object v8, v6

    move-object v14, v7

    move-object v7, v0

    goto/16 :goto_5

    .line 573
    .end local v0    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    :pswitch_5
    move-object/from16 v5, p2

    invoke-virtual {v8, v9, v12, v10}, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_fromInt(Lcom/fasterxml/jackson/core/JsonParser;ILcom/fasterxml/jackson/databind/node/JsonNodeFactory;)Lcom/fasterxml/jackson/databind/JsonNode;

    move-result-object v0

    .line 574
    .restart local v0    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    move-object v8, v6

    move-object v14, v7

    move-object v7, v0

    goto/16 :goto_5

    .line 570
    .end local v0    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    :pswitch_6
    move-object/from16 v5, p2

    invoke-virtual/range {p1 .. p1}, Lcom/fasterxml/jackson/core/JsonParser;->getText()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v10, v0}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->textNode(Ljava/lang/String;)Lcom/fasterxml/jackson/databind/node/TextNode;

    move-result-object v0

    .line 571
    .restart local v0    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    move-object v8, v6

    move-object v14, v7

    move-object v7, v0

    goto/16 :goto_5

    .line 559
    .end local v0    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    :pswitch_7
    move-object/from16 v5, p2

    invoke-virtual/range {p3 .. p3}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->arrayNode()Lcom/fasterxml/jackson/databind/node/ArrayNode;

    move-result-object v13

    .line 560
    .local v13, "newOb":Lcom/fasterxml/jackson/databind/node/ArrayNode;
    invoke-virtual {v7, v6, v13}, Lcom/fasterxml/jackson/databind/node/ObjectNode;->replace(Ljava/lang/String;Lcom/fasterxml/jackson/databind/JsonNode;)Lcom/fasterxml/jackson/databind/JsonNode;

    move-result-object v14

    .line 561
    .local v14, "old":Lcom/fasterxml/jackson/databind/JsonNode;
    if-eqz v14, :cond_2

    .line 562
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    move-object/from16 v3, p3

    move-object v4, v6

    move-object v5, v7

    move-object v8, v6

    .end local v6    # "propName":Ljava/lang/String;
    .restart local v8    # "propName":Ljava/lang/String;
    move-object v6, v14

    move-object/from16 v17, v14

    move-object v14, v7

    .end local v7    # "currObject":Lcom/fasterxml/jackson/databind/node/ObjectNode;
    .local v14, "currObject":Lcom/fasterxml/jackson/databind/node/ObjectNode;
    .local v17, "old":Lcom/fasterxml/jackson/databind/JsonNode;
    move-object v7, v13

    invoke-virtual/range {v0 .. v7}, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_handleDuplicateField(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;Ljava/lang/String;Lcom/fasterxml/jackson/databind/node/ObjectNode;Lcom/fasterxml/jackson/databind/JsonNode;Lcom/fasterxml/jackson/databind/JsonNode;)V

    goto :goto_3

    .line 561
    .end local v8    # "propName":Ljava/lang/String;
    .end local v17    # "old":Lcom/fasterxml/jackson/databind/JsonNode;
    .restart local v6    # "propName":Ljava/lang/String;
    .restart local v7    # "currObject":Lcom/fasterxml/jackson/databind/node/ObjectNode;
    .local v14, "old":Lcom/fasterxml/jackson/databind/JsonNode;
    :cond_2
    move-object v8, v6

    move-object/from16 v17, v14

    move-object v14, v7

    .line 565
    .end local v6    # "propName":Ljava/lang/String;
    .end local v7    # "currObject":Lcom/fasterxml/jackson/databind/node/ObjectNode;
    .restart local v8    # "propName":Ljava/lang/String;
    .local v14, "currObject":Lcom/fasterxml/jackson/databind/node/ObjectNode;
    .restart local v17    # "old":Lcom/fasterxml/jackson/databind/JsonNode;
    :goto_3
    invoke-virtual {v11, v15}, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer$ContainerStack;->push(Lcom/fasterxml/jackson/databind/node/ContainerNode;)V

    .line 566
    move-object v0, v13

    .line 568
    .end local v13    # "newOb":Lcom/fasterxml/jackson/databind/node/ArrayNode;
    .end local v15    # "curr":Lcom/fasterxml/jackson/databind/node/ContainerNode;, "Lcom/fasterxml/jackson/databind/node/ContainerNode<*>;"
    .end local v17    # "old":Lcom/fasterxml/jackson/databind/JsonNode;
    .local v0, "curr":Lcom/fasterxml/jackson/databind/node/ContainerNode;, "Lcom/fasterxml/jackson/databind/node/ContainerNode<*>;"
    move-object/from16 v4, p0

    goto/16 :goto_a

    .line 546
    .end local v0    # "curr":Lcom/fasterxml/jackson/databind/node/ContainerNode;, "Lcom/fasterxml/jackson/databind/node/ContainerNode<*>;"
    .end local v8    # "propName":Ljava/lang/String;
    .end local v14    # "currObject":Lcom/fasterxml/jackson/databind/node/ObjectNode;
    .restart local v6    # "propName":Ljava/lang/String;
    .restart local v7    # "currObject":Lcom/fasterxml/jackson/databind/node/ObjectNode;
    .restart local v15    # "curr":Lcom/fasterxml/jackson/databind/node/ContainerNode;, "Lcom/fasterxml/jackson/databind/node/ContainerNode<*>;"
    :pswitch_8
    move-object v8, v6

    move/from16 v19, v14

    move-object v14, v7

    move/from16 v7, v19

    .end local v6    # "propName":Ljava/lang/String;
    .end local v7    # "currObject":Lcom/fasterxml/jackson/databind/node/ObjectNode;
    .restart local v8    # "propName":Ljava/lang/String;
    .restart local v14    # "currObject":Lcom/fasterxml/jackson/databind/node/ObjectNode;
    invoke-virtual/range {p3 .. p3}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->objectNode()Lcom/fasterxml/jackson/databind/node/ObjectNode;

    move-result-object v6

    .line 547
    .local v6, "newOb":Lcom/fasterxml/jackson/databind/node/ObjectNode;
    invoke-virtual {v14, v8, v6}, Lcom/fasterxml/jackson/databind/node/ObjectNode;->replace(Ljava/lang/String;Lcom/fasterxml/jackson/databind/JsonNode;)Lcom/fasterxml/jackson/databind/JsonNode;

    move-result-object v17

    .line 548
    .restart local v17    # "old":Lcom/fasterxml/jackson/databind/JsonNode;
    if-eqz v17, :cond_3

    .line 549
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    move-object/from16 v3, p3

    move-object v4, v8

    move-object v5, v14

    move-object/from16 v18, v6

    .end local v6    # "newOb":Lcom/fasterxml/jackson/databind/node/ObjectNode;
    .local v18, "newOb":Lcom/fasterxml/jackson/databind/node/ObjectNode;
    move-object/from16 v6, v17

    move-object/from16 v7, v18

    invoke-virtual/range {v0 .. v7}, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_handleDuplicateField(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;Ljava/lang/String;Lcom/fasterxml/jackson/databind/node/ObjectNode;Lcom/fasterxml/jackson/databind/JsonNode;Lcom/fasterxml/jackson/databind/JsonNode;)V

    goto :goto_4

    .line 548
    .end local v18    # "newOb":Lcom/fasterxml/jackson/databind/node/ObjectNode;
    .restart local v6    # "newOb":Lcom/fasterxml/jackson/databind/node/ObjectNode;
    :cond_3
    move-object/from16 v18, v6

    .line 552
    .end local v6    # "newOb":Lcom/fasterxml/jackson/databind/node/ObjectNode;
    .restart local v18    # "newOb":Lcom/fasterxml/jackson/databind/node/ObjectNode;
    :goto_4
    invoke-virtual {v11, v15}, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer$ContainerStack;->push(Lcom/fasterxml/jackson/databind/node/ContainerNode;)V

    .line 553
    move-object/from16 v0, v18

    .end local v14    # "currObject":Lcom/fasterxml/jackson/databind/node/ObjectNode;
    .local v0, "currObject":Lcom/fasterxml/jackson/databind/node/ObjectNode;
    move-object/from16 v15, v18

    .line 555
    move-object v7, v0

    goto :goto_7

    .line 594
    .end local v0    # "currObject":Lcom/fasterxml/jackson/databind/node/ObjectNode;
    .end local v17    # "old":Lcom/fasterxml/jackson/databind/JsonNode;
    .end local v18    # "newOb":Lcom/fasterxml/jackson/databind/node/ObjectNode;
    .local v7, "value":Lcom/fasterxml/jackson/databind/JsonNode;
    .restart local v14    # "currObject":Lcom/fasterxml/jackson/databind/node/ObjectNode;
    :goto_5
    invoke-virtual {v14, v8, v7}, Lcom/fasterxml/jackson/databind/node/ObjectNode;->replace(Ljava/lang/String;Lcom/fasterxml/jackson/databind/JsonNode;)Lcom/fasterxml/jackson/databind/JsonNode;

    move-result-object v17

    .line 595
    .restart local v17    # "old":Lcom/fasterxml/jackson/databind/JsonNode;
    if-eqz v17, :cond_4

    .line 596
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    move-object/from16 v3, p3

    move-object v4, v8

    move-object v5, v14

    move-object/from16 v6, v17

    move-object/from16 v18, v7

    .end local v7    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    .local v18, "value":Lcom/fasterxml/jackson/databind/JsonNode;
    invoke-virtual/range {v0 .. v7}, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_handleDuplicateField(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;Ljava/lang/String;Lcom/fasterxml/jackson/databind/node/ObjectNode;Lcom/fasterxml/jackson/databind/JsonNode;Lcom/fasterxml/jackson/databind/JsonNode;)V

    goto :goto_6

    .line 595
    .end local v18    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    .restart local v7    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    :cond_4
    move-object/from16 v18, v7

    .line 537
    .end local v7    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    .end local v16    # "t":Lcom/fasterxml/jackson/core/JsonToken;
    .end local v17    # "old":Lcom/fasterxml/jackson/databind/JsonNode;
    :goto_6
    move-object v7, v14

    .end local v14    # "currObject":Lcom/fasterxml/jackson/databind/node/ObjectNode;
    .local v7, "currObject":Lcom/fasterxml/jackson/databind/node/ObjectNode;
    :goto_7
    invoke-virtual/range {p1 .. p1}, Lcom/fasterxml/jackson/core/JsonParser;->nextFieldName()Ljava/lang/String;

    move-result-object v6

    const/4 v14, 0x1

    move-object/from16 v8, p0

    .end local v8    # "propName":Ljava/lang/String;
    .local v6, "propName":Ljava/lang/String;
    goto/16 :goto_1

    :cond_5
    move-object v8, v6

    move-object v14, v7

    .line 601
    .end local v6    # "propName":Ljava/lang/String;
    .end local v7    # "currObject":Lcom/fasterxml/jackson/databind/node/ObjectNode;
    move-object/from16 v4, p0

    move-object v0, v15

    goto :goto_9

    .line 603
    .end local v15    # "curr":Lcom/fasterxml/jackson/databind/node/ContainerNode;, "Lcom/fasterxml/jackson/databind/node/ContainerNode<*>;"
    .local v0, "curr":Lcom/fasterxml/jackson/databind/node/ContainerNode;, "Lcom/fasterxml/jackson/databind/node/ContainerNode<*>;"
    :cond_6
    move-object v1, v0

    check-cast v1, Lcom/fasterxml/jackson/databind/node/ArrayNode;

    .line 607
    .local v1, "currArray":Lcom/fasterxml/jackson/databind/node/ArrayNode;
    :goto_8
    invoke-virtual/range {p1 .. p1}, Lcom/fasterxml/jackson/core/JsonParser;->nextToken()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v2

    .line 608
    .local v2, "t":Lcom/fasterxml/jackson/core/JsonToken;
    if-nez v2, :cond_7

    .line 609
    sget-object v2, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    .line 611
    :cond_7
    invoke-virtual {v2}, Lcom/fasterxml/jackson/core/JsonToken;->id()I

    move-result v3

    packed-switch v3, :pswitch_data_1

    .line 643
    :pswitch_9
    const/4 v3, 0x1

    move-object/from16 v4, p0

    invoke-virtual/range {p0 .. p2}, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_deserializeRareScalar(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;)Lcom/fasterxml/jackson/databind/JsonNode;

    move-result-object v5

    invoke-virtual {v1, v5}, Lcom/fasterxml/jackson/databind/node/ArrayNode;->add(Lcom/fasterxml/jackson/databind/JsonNode;)Lcom/fasterxml/jackson/databind/node/ArrayNode;

    .line 644
    goto :goto_8

    .line 640
    :pswitch_a
    invoke-virtual/range {p3 .. p3}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->nullNode()Lcom/fasterxml/jackson/databind/node/NullNode;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/fasterxml/jackson/databind/node/ArrayNode;->add(Lcom/fasterxml/jackson/databind/JsonNode;)Lcom/fasterxml/jackson/databind/node/ArrayNode;

    .line 641
    goto :goto_8

    .line 637
    :pswitch_b
    invoke-virtual {v10, v13}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->booleanNode(Z)Lcom/fasterxml/jackson/databind/node/BooleanNode;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/fasterxml/jackson/databind/node/ArrayNode;->add(Lcom/fasterxml/jackson/databind/JsonNode;)Lcom/fasterxml/jackson/databind/node/ArrayNode;

    .line 638
    goto :goto_8

    .line 634
    :pswitch_c
    const/4 v3, 0x1

    invoke-virtual {v10, v3}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->booleanNode(Z)Lcom/fasterxml/jackson/databind/node/BooleanNode;

    move-result-object v4

    invoke-virtual {v1, v4}, Lcom/fasterxml/jackson/databind/node/ArrayNode;->add(Lcom/fasterxml/jackson/databind/JsonNode;)Lcom/fasterxml/jackson/databind/node/ArrayNode;

    .line 635
    goto :goto_8

    .line 631
    :pswitch_d
    const/4 v3, 0x1

    invoke-virtual/range {p0 .. p3}, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_fromFloat(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;)Lcom/fasterxml/jackson/databind/JsonNode;

    move-result-object v4

    invoke-virtual {v1, v4}, Lcom/fasterxml/jackson/databind/node/ArrayNode;->add(Lcom/fasterxml/jackson/databind/JsonNode;)Lcom/fasterxml/jackson/databind/node/ArrayNode;

    .line 632
    goto :goto_8

    .line 628
    :pswitch_e
    const/4 v3, 0x1

    move-object/from16 v4, p0

    invoke-virtual {v4, v9, v12, v10}, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_fromInt(Lcom/fasterxml/jackson/core/JsonParser;ILcom/fasterxml/jackson/databind/node/JsonNodeFactory;)Lcom/fasterxml/jackson/databind/JsonNode;

    move-result-object v5

    invoke-virtual {v1, v5}, Lcom/fasterxml/jackson/databind/node/ArrayNode;->add(Lcom/fasterxml/jackson/databind/JsonNode;)Lcom/fasterxml/jackson/databind/node/ArrayNode;

    .line 629
    goto :goto_8

    .line 625
    :pswitch_f
    const/4 v3, 0x1

    move-object/from16 v4, p0

    invoke-virtual/range {p1 .. p1}, Lcom/fasterxml/jackson/core/JsonParser;->getText()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v10, v5}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->textNode(Ljava/lang/String;)Lcom/fasterxml/jackson/databind/node/TextNode;

    move-result-object v5

    invoke-virtual {v1, v5}, Lcom/fasterxml/jackson/databind/node/ArrayNode;->add(Lcom/fasterxml/jackson/databind/JsonNode;)Lcom/fasterxml/jackson/databind/node/ArrayNode;

    .line 626
    goto :goto_8

    .line 623
    :pswitch_10
    move-object/from16 v4, p0

    .line 651
    .end local v1    # "currArray":Lcom/fasterxml/jackson/databind/node/ArrayNode;
    .end local v2    # "t":Lcom/fasterxml/jackson/core/JsonToken;
    :goto_9
    invoke-virtual/range {p4 .. p4}, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer$ContainerStack;->popOrNull()Lcom/fasterxml/jackson/databind/node/ContainerNode;

    move-result-object v0

    goto :goto_a

    .line 618
    .restart local v1    # "currArray":Lcom/fasterxml/jackson/databind/node/ArrayNode;
    .restart local v2    # "t":Lcom/fasterxml/jackson/core/JsonToken;
    :pswitch_11
    move-object/from16 v4, p0

    invoke-virtual {v11, v0}, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer$ContainerStack;->push(Lcom/fasterxml/jackson/databind/node/ContainerNode;)V

    .line 619
    invoke-virtual/range {p3 .. p3}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->arrayNode()Lcom/fasterxml/jackson/databind/node/ArrayNode;

    move-result-object v0

    .line 620
    invoke-virtual {v1, v0}, Lcom/fasterxml/jackson/databind/node/ArrayNode;->add(Lcom/fasterxml/jackson/databind/JsonNode;)Lcom/fasterxml/jackson/databind/node/ArrayNode;

    .line 621
    goto :goto_a

    .line 613
    :pswitch_12
    move-object/from16 v4, p0

    invoke-virtual {v11, v0}, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer$ContainerStack;->push(Lcom/fasterxml/jackson/databind/node/ContainerNode;)V

    .line 614
    invoke-virtual/range {p3 .. p3}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->objectNode()Lcom/fasterxml/jackson/databind/node/ObjectNode;

    move-result-object v0

    .line 615
    invoke-virtual {v1, v0}, Lcom/fasterxml/jackson/databind/node/ArrayNode;->add(Lcom/fasterxml/jackson/databind/JsonNode;)Lcom/fasterxml/jackson/databind/node/ArrayNode;

    .line 616
    nop

    .line 652
    .end local v1    # "currArray":Lcom/fasterxml/jackson/databind/node/ArrayNode;
    .end local v2    # "t":Lcom/fasterxml/jackson/core/JsonToken;
    :goto_a
    if-nez v0, :cond_8

    .line 653
    return-object p5

    .line 652
    :cond_8
    move-object v8, v4

    goto/16 :goto_0

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_8
        :pswitch_0
        :pswitch_7
        :pswitch_0
        :pswitch_0
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x1
        :pswitch_12
        :pswitch_9
        :pswitch_11
        :pswitch_10
        :pswitch_9
        :pswitch_f
        :pswitch_e
        :pswitch_d
        :pswitch_c
        :pswitch_b
        :pswitch_a
    .end packed-switch
.end method

.method protected final _deserializeObjectAtName(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer$ContainerStack;)Lcom/fasterxml/jackson/databind/node/ObjectNode;
    .locals 13
    .param p1, "p"    # Lcom/fasterxml/jackson/core/JsonParser;
    .param p2, "ctxt"    # Lcom/fasterxml/jackson/databind/DeserializationContext;
    .param p3, "nodeFactory"    # Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;
    .param p4, "stack"    # Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer$ContainerStack;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 395
    .local p0, "this":Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;, "Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer<TT;>;"
    invoke-virtual/range {p3 .. p3}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->objectNode()Lcom/fasterxml/jackson/databind/node/ObjectNode;

    move-result-object v8

    .line 396
    .local v8, "node":Lcom/fasterxml/jackson/databind/node/ObjectNode;
    invoke-virtual {p1}, Lcom/fasterxml/jackson/core/JsonParser;->currentName()Ljava/lang/String;

    move-result-object v0

    move-object v9, v0

    .line 397
    .local v9, "key":Ljava/lang/String;
    :goto_0
    if-eqz v9, :cond_2

    .line 399
    invoke-virtual {p1}, Lcom/fasterxml/jackson/core/JsonParser;->nextToken()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    .line 400
    .local v0, "t":Lcom/fasterxml/jackson/core/JsonToken;
    if-nez v0, :cond_0

    .line 401
    sget-object v0, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    move-object v10, v0

    goto :goto_1

    .line 400
    :cond_0
    move-object v10, v0

    .line 403
    .end local v0    # "t":Lcom/fasterxml/jackson/core/JsonToken;
    .local v10, "t":Lcom/fasterxml/jackson/core/JsonToken;
    :goto_1
    invoke-virtual {v10}, Lcom/fasterxml/jackson/core/JsonToken;->id()I

    move-result v0

    packed-switch v0, :pswitch_data_0

    .line 413
    :pswitch_0
    invoke-virtual {p0, p1, p2}, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_deserializeAnyScalar(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;)Lcom/fasterxml/jackson/databind/JsonNode;

    move-result-object v0

    move-object v11, v0

    .local v0, "value":Lcom/fasterxml/jackson/databind/JsonNode;
    goto :goto_2

    .line 409
    .end local v0    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    :pswitch_1
    nop

    .line 410
    invoke-virtual/range {p3 .. p3}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->arrayNode()Lcom/fasterxml/jackson/databind/node/ArrayNode;

    move-result-object v6

    .line 409
    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object/from16 v4, p3

    move-object/from16 v5, p4

    invoke-virtual/range {v1 .. v6}, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_deserializeContainerNoRecursion(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer$ContainerStack;Lcom/fasterxml/jackson/databind/node/ContainerNode;)Lcom/fasterxml/jackson/databind/node/ContainerNode;

    move-result-object v0

    .line 411
    .restart local v0    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    move-object v11, v0

    goto :goto_2

    .line 405
    .end local v0    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    :pswitch_2
    nop

    .line 406
    invoke-virtual/range {p3 .. p3}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->objectNode()Lcom/fasterxml/jackson/databind/node/ObjectNode;

    move-result-object v6

    .line 405
    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object/from16 v4, p3

    move-object/from16 v5, p4

    invoke-virtual/range {v1 .. v6}, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_deserializeContainerNoRecursion(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer$ContainerStack;Lcom/fasterxml/jackson/databind/node/ContainerNode;)Lcom/fasterxml/jackson/databind/node/ContainerNode;

    move-result-object v0

    .line 407
    .restart local v0    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    move-object v11, v0

    .line 415
    .end local v0    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    .local v11, "value":Lcom/fasterxml/jackson/databind/JsonNode;
    :goto_2
    invoke-virtual {v8, v9, v11}, Lcom/fasterxml/jackson/databind/node/ObjectNode;->replace(Ljava/lang/String;Lcom/fasterxml/jackson/databind/JsonNode;)Lcom/fasterxml/jackson/databind/JsonNode;

    move-result-object v12

    .line 416
    .local v12, "old":Lcom/fasterxml/jackson/databind/JsonNode;
    if-eqz v12, :cond_1

    .line 417
    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object/from16 v3, p3

    move-object v4, v9

    move-object v5, v8

    move-object v6, v12

    move-object v7, v11

    invoke-virtual/range {v0 .. v7}, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_handleDuplicateField(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;Ljava/lang/String;Lcom/fasterxml/jackson/databind/node/ObjectNode;Lcom/fasterxml/jackson/databind/JsonNode;Lcom/fasterxml/jackson/databind/JsonNode;)V

    .line 397
    .end local v10    # "t":Lcom/fasterxml/jackson/core/JsonToken;
    .end local v11    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    .end local v12    # "old":Lcom/fasterxml/jackson/databind/JsonNode;
    :cond_1
    invoke-virtual {p1}, Lcom/fasterxml/jackson/core/JsonParser;->nextFieldName()Ljava/lang/String;

    move-result-object v9

    goto :goto_0

    .line 421
    :cond_2
    return-object v8

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method protected final _deserializeRareScalar(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;)Lcom/fasterxml/jackson/databind/JsonNode;
    .locals 1
    .param p1, "p"    # Lcom/fasterxml/jackson/core/JsonParser;
    .param p2, "ctxt"    # Lcom/fasterxml/jackson/databind/DeserializationContext;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 689
    .local p0, "this":Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;, "Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer<TT;>;"
    invoke-virtual {p1}, Lcom/fasterxml/jackson/core/JsonParser;->currentTokenId()I

    move-result v0

    sparse-switch v0, :sswitch_data_0

    .line 700
    invoke-virtual {p0}, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->handledType()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {p2, v0, p1}, Lcom/fasterxml/jackson/databind/DeserializationContext;->handleUnexpectedToken(Ljava/lang/Class;Lcom/fasterxml/jackson/core/JsonParser;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/fasterxml/jackson/databind/JsonNode;

    return-object v0

    .line 695
    :sswitch_0
    invoke-virtual {p0, p1, p2}, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_fromEmbedded(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;)Lcom/fasterxml/jackson/databind/JsonNode;

    move-result-object v0

    return-object v0

    .line 693
    :sswitch_1
    invoke-virtual {p2}, Lcom/fasterxml/jackson/databind/DeserializationContext;->getNodeFactory()Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;

    move-result-object v0

    invoke-virtual {p0, p1, p2, v0}, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_fromFloat(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;)Lcom/fasterxml/jackson/databind/JsonNode;

    move-result-object v0

    return-object v0

    .line 691
    :sswitch_2
    invoke-virtual {p2}, Lcom/fasterxml/jackson/databind/DeserializationContext;->getNodeFactory()Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;

    move-result-object v0

    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->objectNode()Lcom/fasterxml/jackson/databind/node/ObjectNode;

    move-result-object v0

    return-object v0

    nop

    :sswitch_data_0
    .sparse-switch
        0x2 -> :sswitch_2
        0x8 -> :sswitch_1
        0xc -> :sswitch_0
    .end sparse-switch
.end method

.method protected final _fromEmbedded(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;)Lcom/fasterxml/jackson/databind/JsonNode;
    .locals 4
    .param p1, "p"    # Lcom/fasterxml/jackson/core/JsonParser;
    .param p2, "ctxt"    # Lcom/fasterxml/jackson/databind/DeserializationContext;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 772
    .local p0, "this":Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;, "Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer<TT;>;"
    invoke-virtual {p2}, Lcom/fasterxml/jackson/databind/DeserializationContext;->getNodeFactory()Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;

    move-result-object v0

    .line 773
    .local v0, "nodeF":Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;
    invoke-virtual {p1}, Lcom/fasterxml/jackson/core/JsonParser;->getEmbeddedObject()Ljava/lang/Object;

    move-result-object v1

    .line 775
    .local v1, "ob":Ljava/lang/Object;
    if-nez v1, :cond_0

    .line 776
    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->nullNode()Lcom/fasterxml/jackson/databind/node/NullNode;

    move-result-object v2

    return-object v2

    .line 778
    :cond_0
    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    .line 779
    .local v2, "type":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    const-class v3, [B

    if-ne v2, v3, :cond_1

    .line 780
    move-object v3, v1

    check-cast v3, [B

    check-cast v3, [B

    invoke-virtual {v0, v3}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->binaryNode([B)Lcom/fasterxml/jackson/databind/node/BinaryNode;

    move-result-object v3

    return-object v3

    .line 783
    :cond_1
    instance-of v3, v1, Lcom/fasterxml/jackson/databind/util/RawValue;

    if-eqz v3, :cond_2

    .line 784
    move-object v3, v1

    check-cast v3, Lcom/fasterxml/jackson/databind/util/RawValue;

    invoke-virtual {v0, v3}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->rawValueNode(Lcom/fasterxml/jackson/databind/util/RawValue;)Lcom/fasterxml/jackson/databind/node/ValueNode;

    move-result-object v3

    return-object v3

    .line 786
    :cond_2
    instance-of v3, v1, Lcom/fasterxml/jackson/databind/JsonNode;

    if-eqz v3, :cond_3

    .line 788
    move-object v3, v1

    check-cast v3, Lcom/fasterxml/jackson/databind/JsonNode;

    return-object v3

    .line 791
    :cond_3
    invoke-virtual {v0, v1}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->pojoNode(Ljava/lang/Object;)Lcom/fasterxml/jackson/databind/node/ValueNode;

    move-result-object v3

    return-object v3
.end method

.method protected final _fromFloat(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;)Lcom/fasterxml/jackson/databind/JsonNode;
    .locals 3
    .param p1, "p"    # Lcom/fasterxml/jackson/core/JsonParser;
    .param p2, "ctxt"    # Lcom/fasterxml/jackson/databind/DeserializationContext;
    .param p3, "nodeFactory"    # Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 751
    .local p0, "this":Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;, "Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer<TT;>;"
    invoke-virtual {p1}, Lcom/fasterxml/jackson/core/JsonParser;->getNumberType()Lcom/fasterxml/jackson/core/JsonParser$NumberType;

    move-result-object v0

    .line 752
    .local v0, "nt":Lcom/fasterxml/jackson/core/JsonParser$NumberType;
    sget-object v1, Lcom/fasterxml/jackson/core/JsonParser$NumberType;->BIG_DECIMAL:Lcom/fasterxml/jackson/core/JsonParser$NumberType;

    if-ne v0, v1, :cond_0

    .line 753
    invoke-virtual {p1}, Lcom/fasterxml/jackson/core/JsonParser;->getDecimalValue()Ljava/math/BigDecimal;

    move-result-object v1

    invoke-virtual {p3, v1}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->numberNode(Ljava/math/BigDecimal;)Lcom/fasterxml/jackson/databind/node/ValueNode;

    move-result-object v1

    return-object v1

    .line 755
    :cond_0
    sget-object v1, Lcom/fasterxml/jackson/databind/DeserializationFeature;->USE_BIG_DECIMAL_FOR_FLOATS:Lcom/fasterxml/jackson/databind/DeserializationFeature;

    invoke-virtual {p2, v1}, Lcom/fasterxml/jackson/databind/DeserializationContext;->isEnabled(Lcom/fasterxml/jackson/databind/DeserializationFeature;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 758
    invoke-virtual {p1}, Lcom/fasterxml/jackson/core/JsonParser;->isNaN()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 759
    invoke-virtual {p1}, Lcom/fasterxml/jackson/core/JsonParser;->getDoubleValue()D

    move-result-wide v1

    invoke-virtual {p3, v1, v2}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->numberNode(D)Lcom/fasterxml/jackson/databind/node/NumericNode;

    move-result-object v1

    return-object v1

    .line 761
    :cond_1
    invoke-virtual {p1}, Lcom/fasterxml/jackson/core/JsonParser;->getDecimalValue()Ljava/math/BigDecimal;

    move-result-object v1

    invoke-virtual {p3, v1}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->numberNode(Ljava/math/BigDecimal;)Lcom/fasterxml/jackson/databind/node/ValueNode;

    move-result-object v1

    return-object v1

    .line 763
    :cond_2
    sget-object v1, Lcom/fasterxml/jackson/core/JsonParser$NumberType;->FLOAT:Lcom/fasterxml/jackson/core/JsonParser$NumberType;

    if-ne v0, v1, :cond_3

    .line 764
    invoke-virtual {p1}, Lcom/fasterxml/jackson/core/JsonParser;->getFloatValue()F

    move-result v1

    invoke-virtual {p3, v1}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->numberNode(F)Lcom/fasterxml/jackson/databind/node/NumericNode;

    move-result-object v1

    return-object v1

    .line 766
    :cond_3
    invoke-virtual {p1}, Lcom/fasterxml/jackson/core/JsonParser;->getDoubleValue()D

    move-result-wide v1

    invoke-virtual {p3, v1, v2}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->numberNode(D)Lcom/fasterxml/jackson/databind/node/NumericNode;

    move-result-object v1

    return-object v1
.end method

.method protected final _fromInt(Lcom/fasterxml/jackson/core/JsonParser;ILcom/fasterxml/jackson/databind/node/JsonNodeFactory;)Lcom/fasterxml/jackson/databind/JsonNode;
    .locals 3
    .param p1, "p"    # Lcom/fasterxml/jackson/core/JsonParser;
    .param p2, "coercionFeatures"    # I
    .param p3, "nodeFactory"    # Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 706
    .local p0, "this":Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;, "Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer<TT;>;"
    if-eqz p2, :cond_1

    .line 707
    sget-object v0, Lcom/fasterxml/jackson/databind/DeserializationFeature;->USE_BIG_INTEGER_FOR_INTS:Lcom/fasterxml/jackson/databind/DeserializationFeature;

    invoke-virtual {v0, p2}, Lcom/fasterxml/jackson/databind/DeserializationFeature;->enabledIn(I)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 708
    invoke-virtual {p1}, Lcom/fasterxml/jackson/core/JsonParser;->getBigIntegerValue()Ljava/math/BigInteger;

    move-result-object v0

    invoke-virtual {p3, v0}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->numberNode(Ljava/math/BigInteger;)Lcom/fasterxml/jackson/databind/node/ValueNode;

    move-result-object v0

    return-object v0

    .line 710
    :cond_0
    invoke-virtual {p1}, Lcom/fasterxml/jackson/core/JsonParser;->getLongValue()J

    move-result-wide v0

    invoke-virtual {p3, v0, v1}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->numberNode(J)Lcom/fasterxml/jackson/databind/node/NumericNode;

    move-result-object v0

    return-object v0

    .line 712
    :cond_1
    invoke-virtual {p1}, Lcom/fasterxml/jackson/core/JsonParser;->getNumberType()Lcom/fasterxml/jackson/core/JsonParser$NumberType;

    move-result-object v0

    .line 713
    .local v0, "nt":Lcom/fasterxml/jackson/core/JsonParser$NumberType;
    sget-object v1, Lcom/fasterxml/jackson/core/JsonParser$NumberType;->INT:Lcom/fasterxml/jackson/core/JsonParser$NumberType;

    if-ne v0, v1, :cond_2

    .line 714
    invoke-virtual {p1}, Lcom/fasterxml/jackson/core/JsonParser;->getIntValue()I

    move-result v1

    invoke-virtual {p3, v1}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->numberNode(I)Lcom/fasterxml/jackson/databind/node/NumericNode;

    move-result-object v1

    return-object v1

    .line 716
    :cond_2
    sget-object v1, Lcom/fasterxml/jackson/core/JsonParser$NumberType;->LONG:Lcom/fasterxml/jackson/core/JsonParser$NumberType;

    if-ne v0, v1, :cond_3

    .line 717
    invoke-virtual {p1}, Lcom/fasterxml/jackson/core/JsonParser;->getLongValue()J

    move-result-wide v1

    invoke-virtual {p3, v1, v2}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->numberNode(J)Lcom/fasterxml/jackson/databind/node/NumericNode;

    move-result-object v1

    return-object v1

    .line 719
    :cond_3
    invoke-virtual {p1}, Lcom/fasterxml/jackson/core/JsonParser;->getBigIntegerValue()Ljava/math/BigInteger;

    move-result-object v1

    invoke-virtual {p3, v1}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->numberNode(Ljava/math/BigInteger;)Lcom/fasterxml/jackson/databind/node/ValueNode;

    move-result-object v1

    return-object v1
.end method

.method protected final _fromInt(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;)Lcom/fasterxml/jackson/databind/JsonNode;
    .locals 4
    .param p1, "p"    # Lcom/fasterxml/jackson/core/JsonParser;
    .param p2, "ctxt"    # Lcom/fasterxml/jackson/databind/DeserializationContext;
    .param p3, "nodeFactory"    # Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 726
    .local p0, "this":Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;, "Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer<TT;>;"
    invoke-virtual {p2}, Lcom/fasterxml/jackson/databind/DeserializationContext;->getDeserializationFeatures()I

    move-result v0

    .line 727
    .local v0, "feats":I
    sget v1, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->F_MASK_INT_COERCIONS:I

    and-int/2addr v1, v0

    if-eqz v1, :cond_2

    .line 728
    sget-object v1, Lcom/fasterxml/jackson/databind/DeserializationFeature;->USE_BIG_INTEGER_FOR_INTS:Lcom/fasterxml/jackson/databind/DeserializationFeature;

    invoke-virtual {v1, v0}, Lcom/fasterxml/jackson/databind/DeserializationFeature;->enabledIn(I)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 729
    sget-object v1, Lcom/fasterxml/jackson/core/JsonParser$NumberType;->BIG_INTEGER:Lcom/fasterxml/jackson/core/JsonParser$NumberType;

    .local v1, "nt":Lcom/fasterxml/jackson/core/JsonParser$NumberType;
    goto :goto_0

    .line 730
    .end local v1    # "nt":Lcom/fasterxml/jackson/core/JsonParser$NumberType;
    :cond_0
    sget-object v1, Lcom/fasterxml/jackson/databind/DeserializationFeature;->USE_LONG_FOR_INTS:Lcom/fasterxml/jackson/databind/DeserializationFeature;

    invoke-virtual {v1, v0}, Lcom/fasterxml/jackson/databind/DeserializationFeature;->enabledIn(I)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 731
    sget-object v1, Lcom/fasterxml/jackson/core/JsonParser$NumberType;->LONG:Lcom/fasterxml/jackson/core/JsonParser$NumberType;

    .restart local v1    # "nt":Lcom/fasterxml/jackson/core/JsonParser$NumberType;
    goto :goto_0

    .line 733
    .end local v1    # "nt":Lcom/fasterxml/jackson/core/JsonParser$NumberType;
    :cond_1
    invoke-virtual {p1}, Lcom/fasterxml/jackson/core/JsonParser;->getNumberType()Lcom/fasterxml/jackson/core/JsonParser$NumberType;

    move-result-object v1

    .restart local v1    # "nt":Lcom/fasterxml/jackson/core/JsonParser$NumberType;
    goto :goto_0

    .line 736
    .end local v1    # "nt":Lcom/fasterxml/jackson/core/JsonParser$NumberType;
    :cond_2
    invoke-virtual {p1}, Lcom/fasterxml/jackson/core/JsonParser;->getNumberType()Lcom/fasterxml/jackson/core/JsonParser$NumberType;

    move-result-object v1

    .line 738
    .restart local v1    # "nt":Lcom/fasterxml/jackson/core/JsonParser$NumberType;
    :goto_0
    sget-object v2, Lcom/fasterxml/jackson/core/JsonParser$NumberType;->INT:Lcom/fasterxml/jackson/core/JsonParser$NumberType;

    if-ne v1, v2, :cond_3

    .line 739
    invoke-virtual {p1}, Lcom/fasterxml/jackson/core/JsonParser;->getIntValue()I

    move-result v2

    invoke-virtual {p3, v2}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->numberNode(I)Lcom/fasterxml/jackson/databind/node/NumericNode;

    move-result-object v2

    return-object v2

    .line 741
    :cond_3
    sget-object v2, Lcom/fasterxml/jackson/core/JsonParser$NumberType;->LONG:Lcom/fasterxml/jackson/core/JsonParser$NumberType;

    if-ne v1, v2, :cond_4

    .line 742
    invoke-virtual {p1}, Lcom/fasterxml/jackson/core/JsonParser;->getLongValue()J

    move-result-wide v2

    invoke-virtual {p3, v2, v3}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->numberNode(J)Lcom/fasterxml/jackson/databind/node/NumericNode;

    move-result-object v2

    return-object v2

    .line 744
    :cond_4
    invoke-virtual {p1}, Lcom/fasterxml/jackson/core/JsonParser;->getBigIntegerValue()Ljava/math/BigInteger;

    move-result-object v2

    invoke-virtual {p3, v2}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->numberNode(Ljava/math/BigInteger;)Lcom/fasterxml/jackson/databind/node/ValueNode;

    move-result-object v2

    return-object v2
.end method

.method protected _handleDuplicateField(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;Ljava/lang/String;Lcom/fasterxml/jackson/databind/node/ObjectNode;Lcom/fasterxml/jackson/databind/JsonNode;Lcom/fasterxml/jackson/databind/JsonNode;)V
    .locals 3
    .param p1, "p"    # Lcom/fasterxml/jackson/core/JsonParser;
    .param p2, "ctxt"    # Lcom/fasterxml/jackson/databind/DeserializationContext;
    .param p3, "nodeFactory"    # Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;
    .param p4, "fieldName"    # Ljava/lang/String;
    .param p5, "objectNode"    # Lcom/fasterxml/jackson/databind/node/ObjectNode;
    .param p6, "oldValue"    # Lcom/fasterxml/jackson/databind/JsonNode;
    .param p7, "newValue"    # Lcom/fasterxml/jackson/databind/JsonNode;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 358
    .local p0, "this":Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;, "Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer<TT;>;"
    sget-object v0, Lcom/fasterxml/jackson/databind/DeserializationFeature;->FAIL_ON_READING_DUP_TREE_KEY:Lcom/fasterxml/jackson/databind/DeserializationFeature;

    invoke-virtual {p2, v0}, Lcom/fasterxml/jackson/databind/DeserializationContext;->isEnabled(Lcom/fasterxml/jackson/databind/DeserializationFeature;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 362
    const-class v0, Lcom/fasterxml/jackson/databind/JsonNode;

    const-string v1, "Duplicate field \'%s\' for `ObjectNode`: not allowed when `DeserializationFeature.FAIL_ON_READING_DUP_TREE_KEY` enabled"

    filled-new-array {p4}, [Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {p2, v0, v1, v2}, Lcom/fasterxml/jackson/databind/DeserializationContext;->reportInputMismatch(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    .line 367
    :cond_0
    sget-object v0, Lcom/fasterxml/jackson/core/StreamReadCapability;->DUPLICATE_PROPERTIES:Lcom/fasterxml/jackson/core/StreamReadCapability;

    invoke-virtual {p2, v0}, Lcom/fasterxml/jackson/databind/DeserializationContext;->isEnabled(Lcom/fasterxml/jackson/core/StreamReadCapability;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 370
    invoke-virtual {p6}, Lcom/fasterxml/jackson/databind/JsonNode;->isArray()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 371
    move-object v0, p6

    check-cast v0, Lcom/fasterxml/jackson/databind/node/ArrayNode;

    invoke-virtual {v0, p7}, Lcom/fasterxml/jackson/databind/node/ArrayNode;->add(Lcom/fasterxml/jackson/databind/JsonNode;)Lcom/fasterxml/jackson/databind/node/ArrayNode;

    .line 372
    invoke-virtual {p5, p4, p6}, Lcom/fasterxml/jackson/databind/node/ObjectNode;->replace(Ljava/lang/String;Lcom/fasterxml/jackson/databind/JsonNode;)Lcom/fasterxml/jackson/databind/JsonNode;

    goto :goto_0

    .line 374
    :cond_1
    invoke-virtual {p3}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->arrayNode()Lcom/fasterxml/jackson/databind/node/ArrayNode;

    move-result-object v0

    .line 375
    .local v0, "arr":Lcom/fasterxml/jackson/databind/node/ArrayNode;
    invoke-virtual {v0, p6}, Lcom/fasterxml/jackson/databind/node/ArrayNode;->add(Lcom/fasterxml/jackson/databind/JsonNode;)Lcom/fasterxml/jackson/databind/node/ArrayNode;

    .line 376
    invoke-virtual {v0, p7}, Lcom/fasterxml/jackson/databind/node/ArrayNode;->add(Lcom/fasterxml/jackson/databind/JsonNode;)Lcom/fasterxml/jackson/databind/node/ArrayNode;

    .line 377
    invoke-virtual {p5, p4, v0}, Lcom/fasterxml/jackson/databind/node/ObjectNode;->replace(Ljava/lang/String;Lcom/fasterxml/jackson/databind/JsonNode;)Lcom/fasterxml/jackson/databind/JsonNode;

    .line 380
    .end local v0    # "arr":Lcom/fasterxml/jackson/databind/node/ArrayNode;
    :cond_2
    :goto_0
    return-void
.end method

.method public createContextual(Lcom/fasterxml/jackson/databind/DeserializationContext;Lcom/fasterxml/jackson/databind/BeanProperty;)Lcom/fasterxml/jackson/databind/JsonDeserializer;
    .locals 7
    .param p1, "ctxt"    # Lcom/fasterxml/jackson/databind/DeserializationContext;
    .param p2, "property"    # Lcom/fasterxml/jackson/databind/BeanProperty;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/fasterxml/jackson/databind/DeserializationContext;",
            "Lcom/fasterxml/jackson/databind/BeanProperty;",
            ")",
            "Lcom/fasterxml/jackson/databind/JsonDeserializer<",
            "*>;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/fasterxml/jackson/databind/JsonMappingException;
        }
    .end annotation

    .line 302
    .local p0, "this":Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;, "Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer<TT;>;"
    invoke-virtual {p1}, Lcom/fasterxml/jackson/databind/DeserializationContext;->getConfig()Lcom/fasterxml/jackson/databind/DeserializationConfig;

    move-result-object v0

    .line 303
    .local v0, "cfg":Lcom/fasterxml/jackson/databind/DeserializationConfig;
    const-class v1, Lcom/fasterxml/jackson/databind/node/ArrayNode;

    invoke-virtual {v0, v1}, Lcom/fasterxml/jackson/databind/DeserializationConfig;->getDefaultMergeable(Ljava/lang/Class;)Ljava/lang/Boolean;

    move-result-object v1

    .line 304
    .local v1, "mergeArr":Ljava/lang/Boolean;
    const-class v2, Lcom/fasterxml/jackson/databind/node/ObjectNode;

    invoke-virtual {v0, v2}, Lcom/fasterxml/jackson/databind/DeserializationConfig;->getDefaultMergeable(Ljava/lang/Class;)Ljava/lang/Boolean;

    move-result-object v2

    .line 305
    .local v2, "mergeObj":Ljava/lang/Boolean;
    const-class v3, Lcom/fasterxml/jackson/databind/JsonNode;

    invoke-virtual {v0, v3}, Lcom/fasterxml/jackson/databind/DeserializationConfig;->getDefaultMergeable(Ljava/lang/Class;)Ljava/lang/Boolean;

    move-result-object v3

    .line 307
    .local v3, "mergeNode":Ljava/lang/Boolean;
    invoke-static {v1, v3}, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_shouldMerge(Ljava/lang/Boolean;Ljava/lang/Boolean;)Z

    move-result v4

    .line 308
    .local v4, "mergeArrays":Z
    invoke-static {v2, v3}, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_shouldMerge(Ljava/lang/Boolean;Ljava/lang/Boolean;)Z

    move-result v5

    .line 310
    .local v5, "mergeObjects":Z
    iget-boolean v6, p0, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_mergeArrays:Z

    if-ne v4, v6, :cond_1

    iget-boolean v6, p0, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_mergeObjects:Z

    if-eq v5, v6, :cond_0

    goto :goto_0

    .line 315
    :cond_0
    return-object p0

    .line 312
    :cond_1
    :goto_0
    invoke-virtual {p0, v4, v5}, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_createWithMerge(ZZ)Lcom/fasterxml/jackson/databind/JsonDeserializer;

    move-result-object v6

    return-object v6
.end method

.method public deserializeWithType(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;Lcom/fasterxml/jackson/databind/jsontype/TypeDeserializer;)Ljava/lang/Object;
    .locals 1
    .param p1, "p"    # Lcom/fasterxml/jackson/core/JsonParser;
    .param p2, "ctxt"    # Lcom/fasterxml/jackson/databind/DeserializationContext;
    .param p3, "typeDeserializer"    # Lcom/fasterxml/jackson/databind/jsontype/TypeDeserializer;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 276
    .local p0, "this":Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;, "Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer<TT;>;"
    invoke-virtual {p3, p1, p2}, Lcom/fasterxml/jackson/databind/jsontype/TypeDeserializer;->deserializeTypedFromAny(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public isCachable()Z
    .locals 1

    .line 288
    .local p0, "this":Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;, "Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer<TT;>;"
    const/4 v0, 0x1

    return v0
.end method

.method public logicalType()Lcom/fasterxml/jackson/databind/type/LogicalType;
    .locals 1

    .line 281
    .local p0, "this":Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;, "Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer<TT;>;"
    sget-object v0, Lcom/fasterxml/jackson/databind/type/LogicalType;->Untyped:Lcom/fasterxml/jackson/databind/type/LogicalType;

    return-object v0
.end method

.method public supportsUpdate(Lcom/fasterxml/jackson/databind/DeserializationConfig;)Ljava/lang/Boolean;
    .locals 1
    .param p1, "config"    # Lcom/fasterxml/jackson/databind/DeserializationConfig;

    .line 292
    .local p0, "this":Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;, "Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer<TT;>;"
    iget-object v0, p0, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_supportsUpdates:Ljava/lang/Boolean;

    return-object v0
.end method

.method protected final updateObject(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;Lcom/fasterxml/jackson/databind/node/ObjectNode;Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer$ContainerStack;)Lcom/fasterxml/jackson/databind/JsonNode;
    .locals 10
    .param p1, "p"    # Lcom/fasterxml/jackson/core/JsonParser;
    .param p2, "ctxt"    # Lcom/fasterxml/jackson/databind/DeserializationContext;
    .param p3, "node"    # Lcom/fasterxml/jackson/databind/node/ObjectNode;
    .param p4, "stack"    # Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer$ContainerStack;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 434
    .local p0, "this":Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;, "Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer<TT;>;"
    invoke-virtual {p1}, Lcom/fasterxml/jackson/core/JsonParser;->isExpectedStartObjectToken()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 435
    invoke-virtual {p1}, Lcom/fasterxml/jackson/core/JsonParser;->nextFieldName()Ljava/lang/String;

    move-result-object v0

    .local v0, "key":Ljava/lang/String;
    goto :goto_0

    .line 437
    .end local v0    # "key":Ljava/lang/String;
    :cond_0
    sget-object v0, Lcom/fasterxml/jackson/core/JsonToken;->FIELD_NAME:Lcom/fasterxml/jackson/core/JsonToken;

    invoke-virtual {p1, v0}, Lcom/fasterxml/jackson/core/JsonParser;->hasToken(Lcom/fasterxml/jackson/core/JsonToken;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 438
    invoke-virtual {p0, p1, p2}, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->deserialize(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/fasterxml/jackson/databind/JsonNode;

    return-object v0

    .line 440
    :cond_1
    invoke-virtual {p1}, Lcom/fasterxml/jackson/core/JsonParser;->currentName()Ljava/lang/String;

    move-result-object v0

    .line 442
    .restart local v0    # "key":Ljava/lang/String;
    :goto_0
    invoke-virtual {p2}, Lcom/fasterxml/jackson/databind/DeserializationContext;->getNodeFactory()Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;

    move-result-object v7

    .line 443
    .local v7, "nodeFactory":Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;
    :goto_1
    if-eqz v0, :cond_7

    .line 445
    invoke-virtual {p1}, Lcom/fasterxml/jackson/core/JsonParser;->nextToken()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v8

    .line 448
    .local v8, "t":Lcom/fasterxml/jackson/core/JsonToken;
    invoke-virtual {p3, v0}, Lcom/fasterxml/jackson/databind/node/ObjectNode;->get(Ljava/lang/String;)Lcom/fasterxml/jackson/databind/JsonNode;

    move-result-object v9

    .line 449
    .local v9, "old":Lcom/fasterxml/jackson/databind/JsonNode;
    if-eqz v9, :cond_3

    .line 450
    instance-of v1, v9, Lcom/fasterxml/jackson/databind/node/ObjectNode;

    if-eqz v1, :cond_2

    .line 453
    sget-object v1, Lcom/fasterxml/jackson/core/JsonToken;->START_OBJECT:Lcom/fasterxml/jackson/core/JsonToken;

    if-ne v8, v1, :cond_3

    iget-boolean v1, p0, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_mergeObjects:Z

    if-eqz v1, :cond_3

    .line 454
    move-object v1, v9

    check-cast v1, Lcom/fasterxml/jackson/databind/node/ObjectNode;

    invoke-virtual {p0, p1, p2, v1, p4}, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->updateObject(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;Lcom/fasterxml/jackson/databind/node/ObjectNode;Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer$ContainerStack;)Lcom/fasterxml/jackson/databind/JsonNode;

    move-result-object v1

    .line 455
    .local v1, "newValue":Lcom/fasterxml/jackson/databind/JsonNode;
    if-eq v1, v9, :cond_6

    .line 456
    invoke-virtual {p3, v0, v1}, Lcom/fasterxml/jackson/databind/node/ObjectNode;->set(Ljava/lang/String;Lcom/fasterxml/jackson/databind/JsonNode;)Lcom/fasterxml/jackson/databind/JsonNode;

    goto/16 :goto_3

    .line 460
    .end local v1    # "newValue":Lcom/fasterxml/jackson/databind/JsonNode;
    :cond_2
    instance-of v1, v9, Lcom/fasterxml/jackson/databind/node/ArrayNode;

    if-eqz v1, :cond_3

    .line 463
    sget-object v1, Lcom/fasterxml/jackson/core/JsonToken;->START_ARRAY:Lcom/fasterxml/jackson/core/JsonToken;

    if-ne v8, v1, :cond_3

    iget-boolean v1, p0, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_mergeArrays:Z

    if-eqz v1, :cond_3

    .line 466
    move-object v6, v9

    check-cast v6, Lcom/fasterxml/jackson/databind/node/ArrayNode;

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, v7

    move-object v5, p4

    invoke-virtual/range {v1 .. v6}, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_deserializeContainerNoRecursion(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer$ContainerStack;Lcom/fasterxml/jackson/databind/node/ContainerNode;)Lcom/fasterxml/jackson/databind/node/ContainerNode;

    .line 468
    goto/16 :goto_3

    .line 472
    :cond_3
    if-nez v8, :cond_4

    .line 473
    sget-object v8, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    .line 476
    :cond_4
    invoke-virtual {v8}, Lcom/fasterxml/jackson/core/JsonToken;->id()I

    move-result v1

    packed-switch v1, :pswitch_data_0

    .line 505
    :pswitch_0
    invoke-virtual {p0, p1, p2}, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_deserializeRareScalar(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;)Lcom/fasterxml/jackson/databind/JsonNode;

    move-result-object v1

    .local v1, "value":Lcom/fasterxml/jackson/databind/JsonNode;
    goto :goto_2

    .line 499
    .end local v1    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    :pswitch_1
    sget-object v1, Lcom/fasterxml/jackson/databind/cfg/JsonNodeFeature;->READ_NULL_PROPERTIES:Lcom/fasterxml/jackson/databind/cfg/JsonNodeFeature;

    invoke-virtual {p2, v1}, Lcom/fasterxml/jackson/databind/DeserializationContext;->isEnabled(Lcom/fasterxml/jackson/databind/cfg/DatatypeFeature;)Z

    move-result v1

    if-nez v1, :cond_5

    .line 500
    goto :goto_3

    .line 502
    :cond_5
    invoke-virtual {v7}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->nullNode()Lcom/fasterxml/jackson/databind/node/NullNode;

    move-result-object v1

    .line 503
    .restart local v1    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    goto :goto_2

    .line 495
    .end local v1    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    :pswitch_2
    const/4 v1, 0x0

    invoke-virtual {v7, v1}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->booleanNode(Z)Lcom/fasterxml/jackson/databind/node/BooleanNode;

    move-result-object v1

    .line 496
    .restart local v1    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    goto :goto_2

    .line 492
    .end local v1    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    :pswitch_3
    const/4 v1, 0x1

    invoke-virtual {v7, v1}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->booleanNode(Z)Lcom/fasterxml/jackson/databind/node/BooleanNode;

    move-result-object v1

    .line 493
    .restart local v1    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    goto :goto_2

    .line 489
    .end local v1    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    :pswitch_4
    invoke-virtual {p0, p1, p2, v7}, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_fromInt(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;)Lcom/fasterxml/jackson/databind/JsonNode;

    move-result-object v1

    .line 490
    .restart local v1    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    goto :goto_2

    .line 486
    .end local v1    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    :pswitch_5
    invoke-virtual {p1}, Lcom/fasterxml/jackson/core/JsonParser;->getText()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v7, v1}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->textNode(Ljava/lang/String;)Lcom/fasterxml/jackson/databind/node/TextNode;

    move-result-object v1

    .line 487
    .restart local v1    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    goto :goto_2

    .line 482
    .end local v1    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    :pswitch_6
    nop

    .line 483
    invoke-virtual {v7}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->arrayNode()Lcom/fasterxml/jackson/databind/node/ArrayNode;

    move-result-object v6

    .line 482
    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, v7

    move-object v5, p4

    invoke-virtual/range {v1 .. v6}, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_deserializeContainerNoRecursion(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer$ContainerStack;Lcom/fasterxml/jackson/databind/node/ContainerNode;)Lcom/fasterxml/jackson/databind/node/ContainerNode;

    move-result-object v1

    .line 484
    .restart local v1    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    goto :goto_2

    .line 478
    .end local v1    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    :pswitch_7
    nop

    .line 479
    invoke-virtual {v7}, Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;->objectNode()Lcom/fasterxml/jackson/databind/node/ObjectNode;

    move-result-object v6

    .line 478
    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, v7

    move-object v5, p4

    invoke-virtual/range {v1 .. v6}, Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer;->_deserializeContainerNoRecursion(Lcom/fasterxml/jackson/core/JsonParser;Lcom/fasterxml/jackson/databind/DeserializationContext;Lcom/fasterxml/jackson/databind/node/JsonNodeFactory;Lcom/fasterxml/jackson/databind/deser/std/BaseNodeDeserializer$ContainerStack;Lcom/fasterxml/jackson/databind/node/ContainerNode;)Lcom/fasterxml/jackson/databind/node/ContainerNode;

    move-result-object v1

    .line 480
    .restart local v1    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    nop

    .line 516
    :goto_2
    invoke-virtual {p3, v0, v1}, Lcom/fasterxml/jackson/databind/node/ObjectNode;->set(Ljava/lang/String;Lcom/fasterxml/jackson/databind/JsonNode;)Lcom/fasterxml/jackson/databind/JsonNode;

    .line 443
    .end local v1    # "value":Lcom/fasterxml/jackson/databind/JsonNode;
    .end local v8    # "t":Lcom/fasterxml/jackson/core/JsonToken;
    .end local v9    # "old":Lcom/fasterxml/jackson/databind/JsonNode;
    :cond_6
    :goto_3
    invoke-virtual {p1}, Lcom/fasterxml/jackson/core/JsonParser;->nextFieldName()Ljava/lang/String;

    move-result-object v0

    goto/16 :goto_1

    .line 518
    :cond_7
    return-object p3

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_7
        :pswitch_0
        :pswitch_6
        :pswitch_0
        :pswitch_0
        :pswitch_5
        :pswitch_4
        :pswitch_0
        :pswitch_3
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method
