.class public Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$NluResult;
.super Ljava/lang/Object;
.source "RokidRFMLite.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "NluResult"
.end annotation


# instance fields
.field public asr:Ljava/lang/String;

.field public deviceId:Ljava/lang/String;

.field public intent:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$IntentResult;

.field public predictType:I

.field public rt:F

.field public sessionId:Ljava/lang/String;

.field public slot:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$SlotResult;

.field public status:I

.field public terminalType:Ljava/lang/String;

.field public traceId:Ljava/lang/String;

.field public version:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 323
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 333
    const-string v0, "Android"

    iput-object v0, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$NluResult;->terminalType:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public toString()Ljava/lang/String;
    .locals 4

    .line 338
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 340
    .local v0, "json":Lorg/json/JSONObject;
    :try_start_0
    const-string/jumbo v1, "status"

    iget v2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$NluResult;->status:I

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 341
    const-string v1, "predictType"

    iget v2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$NluResult;->predictType:I

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 342
    const-string v1, "asr"

    iget-object v2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$NluResult;->asr:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 343
    const-string/jumbo v1, "sessionId"

    iget-object v2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$NluResult;->sessionId:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 344
    const-string/jumbo v1, "traceId"

    iget-object v2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$NluResult;->traceId:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 345
    const-string/jumbo v1, "rt"

    iget v2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$NluResult;->rt:F

    invoke-static {v2}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;->-$$Nest$smformatFloat(F)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 346
    const-string v1, "deviceId"

    iget-object v2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$NluResult;->deviceId:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 347
    const-string/jumbo v1, "version"

    iget-object v2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$NluResult;->version:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 348
    const-string/jumbo v1, "terminalType"

    iget-object v2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$NluResult;->terminalType:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 351
    const-string v1, "intent"

    iget-object v2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$NluResult;->intent:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$IntentResult;

    const/4 v3, 0x0

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$NluResult;->intent:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$IntentResult;

    invoke-virtual {v2}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$IntentResult;->toJson()Lorg/json/JSONObject;

    move-result-object v2

    goto :goto_0

    :cond_0
    move-object v2, v3

    :goto_0
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 352
    const-string/jumbo v1, "slot"

    iget-object v2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$NluResult;->slot:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$SlotResult;

    if-eqz v2, :cond_1

    iget-object v2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$NluResult;->slot:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$SlotResult;

    invoke-virtual {v2}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$SlotResult;->toJson()Lorg/json/JSONObject;

    move-result-object v3

    :cond_1
    invoke-virtual {v0, v1, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 355
    goto :goto_1

    .line 353
    :catch_0
    move-exception v1

    .line 354
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 356
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_1
    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method
