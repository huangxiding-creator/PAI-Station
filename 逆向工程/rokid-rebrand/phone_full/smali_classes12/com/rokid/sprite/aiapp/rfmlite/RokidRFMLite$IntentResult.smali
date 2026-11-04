.class public Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$IntentResult;
.super Ljava/lang/Object;
.source "RokidRFMLite.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "IntentResult"
.end annotation


# instance fields
.field public intent:I

.field public predictType:I

.field public rt:F

.field public status:I


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 360
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public toJson()Lorg/json/JSONObject;
    .locals 3

    .line 367
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 369
    .local v0, "json":Lorg/json/JSONObject;
    :try_start_0
    const-string/jumbo v1, "status"

    iget v2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$IntentResult;->status:I

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 370
    const-string v1, "intent"

    iget v2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$IntentResult;->intent:I

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 371
    const-string v1, "predictType"

    iget v2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$IntentResult;->predictType:I

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 372
    const-string/jumbo v1, "rt"

    iget v2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$IntentResult;->rt:F

    invoke-static {v2}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;->-$$Nest$smformatFloat(F)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 375
    goto :goto_0

    .line 373
    :catch_0
    move-exception v1

    .line 374
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 376
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_0
    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 381
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 383
    .local v0, "json":Lorg/json/JSONObject;
    :try_start_0
    const-string/jumbo v1, "status"

    iget v2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$IntentResult;->status:I

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 384
    const-string v1, "intent"

    iget v2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$IntentResult;->intent:I

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 385
    const-string v1, "predictType"

    iget v2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$IntentResult;->predictType:I

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 386
    const-string/jumbo v1, "rt"

    iget v2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$IntentResult;->rt:F

    invoke-static {v2}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;->-$$Nest$smformatFloat(F)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 389
    goto :goto_0

    .line 387
    :catch_0
    move-exception v1

    .line 388
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 390
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_0
    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method
