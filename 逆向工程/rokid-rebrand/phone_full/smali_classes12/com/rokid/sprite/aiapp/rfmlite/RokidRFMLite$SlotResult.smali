.class public Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$SlotResult;
.super Ljava/lang/Object;
.source "RokidRFMLite.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "SlotResult"
.end annotation


# instance fields
.field public rt:F

.field public slots:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Landroid/util/Pair<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;>;"
        }
    .end annotation
.end field

.field public status:I


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 394
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 397
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$SlotResult;->slots:Ljava/util/List;

    return-void
.end method

.method private slotsToJson()Lorg/json/JSONArray;
    .locals 6

    .line 412
    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    .line 413
    .local v0, "jsonArray":Lorg/json/JSONArray;
    iget-object v1, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$SlotResult;->slots:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/util/Pair;

    .line 414
    .local v2, "slot":Landroid/util/Pair;, "Landroid/util/Pair<Ljava/lang/String;Ljava/lang/String;>;"
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3}, Lorg/json/JSONObject;-><init>()V

    .line 416
    .local v3, "slotJson":Lorg/json/JSONObject;
    :try_start_0
    const-string/jumbo v4, "slot_name"

    iget-object v5, v2, Landroid/util/Pair;->first:Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 417
    const-string/jumbo v4, "slot_value"

    iget-object v5, v2, Landroid/util/Pair;->second:Ljava/lang/Object;

    invoke-virtual {v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 420
    goto :goto_1

    .line 418
    :catch_0
    move-exception v4

    .line 419
    .local v4, "e":Ljava/lang/Exception;
    invoke-virtual {v4}, Ljava/lang/Exception;->printStackTrace()V

    .line 421
    .end local v4    # "e":Ljava/lang/Exception;
    :goto_1
    invoke-virtual {v0, v3}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 422
    .end local v2    # "slot":Landroid/util/Pair;, "Landroid/util/Pair<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v3    # "slotJson":Lorg/json/JSONObject;
    goto :goto_0

    .line 423
    :cond_0
    return-object v0
.end method


# virtual methods
.method public toJson()Lorg/json/JSONObject;
    .locals 3

    .line 400
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 402
    .local v0, "json":Lorg/json/JSONObject;
    :try_start_0
    const-string/jumbo v1, "status"

    iget v2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$SlotResult;->status:I

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 403
    const-string/jumbo v1, "rt"

    iget v2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$SlotResult;->rt:F

    invoke-static {v2}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;->-$$Nest$smformatFloat(F)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 404
    const-string/jumbo v1, "slots"

    invoke-direct {p0}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$SlotResult;->slotsToJson()Lorg/json/JSONArray;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 407
    goto :goto_0

    .line 405
    :catch_0
    move-exception v1

    .line 406
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 408
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_0
    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 428
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 430
    .local v0, "json":Lorg/json/JSONObject;
    :try_start_0
    const-string/jumbo v1, "status"

    iget v2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$SlotResult;->status:I

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 431
    const-string/jumbo v1, "rt"

    iget v2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$SlotResult;->rt:F

    invoke-static {v2}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;->-$$Nest$smformatFloat(F)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 432
    const-string/jumbo v1, "slots"

    iget-object v2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$SlotResult;->slots:Ljava/util/List;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$SlotResult;->slots:Ljava/util/List;

    invoke-virtual {v2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    :goto_0
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 435
    goto :goto_1

    .line 433
    :catch_0
    move-exception v1

    .line 434
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 436
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_1
    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method
