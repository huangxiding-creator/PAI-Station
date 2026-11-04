.class public final Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;
.super Ljava/lang/Object;
.source "OnlineRecManager.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nOnlineRecManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 OnlineRecManager.kt\ncom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,226:1\n1#2:227\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000_\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010\u0012\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0010\u0002\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\u0003*\u0001\u000f\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002J\u0006\u0010\u0018\u001a\u00020\u0019J\u0010\u0010\u001a\u001a\u00020\u00192\u0006\u0010\u001b\u001a\u00020\u0004H\u0002J\u0010\u0010\u001c\u001a\u00020\u00192\u0006\u0010\u001d\u001a\u00020\u001eH\u0002J\u0006\u0010\u001f\u001a\u00020\u0019J0\u0010 \u001a\u00020\u00192\u0006\u0010!\u001a\u00020\"2\n\u0008\u0002\u0010#\u001a\u0004\u0018\u00010$2\u0008\u0008\u0002\u0010%\u001a\u00020\u00042\u0008\u0008\u0002\u0010&\u001a\u00020\'H\u0002J\u0010\u0010(\u001a\u00020\u00192\u0008\u0010)\u001a\u0004\u0018\u00010\u0012R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u001a\u0010\u0005\u001a\u000e\u0012\u0004\u0012\u00020\u0004\u0012\u0004\u0012\u00020\u00070\u0006X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u001b\u0010\u0008\u001a\u00020\t8BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\u000c\u0010\r\u001a\u0004\u0008\n\u0010\u000bR\u0010\u0010\u000e\u001a\u00020\u000fX\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u0010R\u0010\u0010\u0011\u001a\u0004\u0018\u00010\u0012X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u001b\u0010\u0013\u001a\u00020\u00148BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\u0017\u0010\r\u001a\u0004\u0008\u0015\u0010\u0016\u00a8\u0006*"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;",
        "",
        "()V",
        "TAG",
        "",
        "dataMap",
        "Lcom/rokid/security/phone/sdk/server/common/FixedSizeMap;",
        "",
        "mFileSystemRepository",
        "Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;",
        "getMFileSystemRepository",
        "()Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;",
        "mFileSystemRepository$delegate",
        "Lkotlin/Lazy;",
        "mInterMessageListener",
        "com/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$mInterMessageListener$1",
        "Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$mInterMessageListener$1;",
        "mRecProvider",
        "Lcom/rokid/security/phone/sdk/api/recog/online/api/IRecProvider;",
        "mRecognitionRepository",
        "Lcom/rokid/security/phone/sdk/server/recog/online/repository/RecognitionRepository;",
        "getMRecognitionRepository",
        "()Lcom/rokid/security/phone/sdk/server/recog/online/repository/RecognitionRepository;",
        "mRecognitionRepository$delegate",
        "init",
        "",
        "parseMessage",
        "msg",
        "recognizeFace",
        "extra",
        "Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;",
        "release",
        "sendRecogFaceResponseMsg",
        "isSuccess",
        "",
        "personInfo",
        "Lcom/rokid/security/sdk/base/common/outside/RecognizePersonInfo;",
        "errorMsg",
        "errorCode",
        "",
        "setRecProvider",
        "recProvider",
        "sdk-server_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field private final TAG:Ljava/lang/String;

.field private final dataMap:Lcom/rokid/security/phone/sdk/server/common/FixedSizeMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/rokid/security/phone/sdk/server/common/FixedSizeMap<",
            "Ljava/lang/String;",
            "[B>;"
        }
    .end annotation
.end field

.field private final mFileSystemRepository$delegate:Lkotlin/Lazy;

.field private final mInterMessageListener:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$mInterMessageListener$1;

.field private mRecProvider:Lcom/rokid/security/phone/sdk/api/recog/online/api/IRecProvider;

.field private final mRecognitionRepository$delegate:Lkotlin/Lazy;


# direct methods
.method public constructor <init>()V
    .locals 3

    .line 33
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 34
    const-string v0, "OnlineRecManager-OnlineFaceRec "

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->TAG:Ljava/lang/String;

    .line 36
    new-instance v0, Lcom/rokid/security/phone/sdk/server/common/FixedSizeMap;

    const/16 v1, 0x1e

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Lcom/rokid/security/phone/sdk/server/common/FixedSizeMap;-><init>(IZ)V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->dataMap:Lcom/rokid/security/phone/sdk/server/common/FixedSizeMap;

    .line 37
    sget-object v0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$mRecognitionRepository$2;->INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$mRecognitionRepository$2;

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->mRecognitionRepository$delegate:Lkotlin/Lazy;

    .line 38
    sget-object v0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$mFileSystemRepository$2;->INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$mFileSystemRepository$2;

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->mFileSystemRepository$delegate:Lkotlin/Lazy;

    .line 41
    new-instance v0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$mInterMessageListener$1;

    invoke-direct {v0, p0}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$mInterMessageListener$1;-><init>(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;)V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$mInterMessageListener$1;

    .line 33
    return-void
.end method

.method public static final synthetic access$getDataMap$p(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;)Lcom/rokid/security/phone/sdk/server/common/FixedSizeMap;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    .line 33
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->dataMap:Lcom/rokid/security/phone/sdk/server/common/FixedSizeMap;

    return-object v0
.end method

.method public static final synthetic access$getMRecProvider$p(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;)Lcom/rokid/security/phone/sdk/api/recog/online/api/IRecProvider;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    .line 33
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->mRecProvider:Lcom/rokid/security/phone/sdk/api/recog/online/api/IRecProvider;

    return-object v0
.end method

.method public static final synthetic access$getMRecognitionRepository(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;)Lcom/rokid/security/phone/sdk/server/recog/online/repository/RecognitionRepository;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    .line 33
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->getMRecognitionRepository()Lcom/rokid/security/phone/sdk/server/recog/online/repository/RecognitionRepository;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$getTAG$p(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;)Ljava/lang/String;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;

    .line 33
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$parseMessage(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;
    .param p1, "msg"    # Ljava/lang/String;

    .line 33
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->parseMessage(Ljava/lang/String;)V

    return-void
.end method

.method public static final synthetic access$sendRecogFaceResponseMsg(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;ZLcom/rokid/security/sdk/base/common/outside/RecognizePersonInfo;Ljava/lang/String;I)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;
    .param p1, "isSuccess"    # Z
    .param p2, "personInfo"    # Lcom/rokid/security/sdk/base/common/outside/RecognizePersonInfo;
    .param p3, "errorMsg"    # Ljava/lang/String;
    .param p4, "errorCode"    # I

    .line 33
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->sendRecogFaceResponseMsg(ZLcom/rokid/security/sdk/base/common/outside/RecognizePersonInfo;Ljava/lang/String;I)V

    return-void
.end method

.method private final getMFileSystemRepository()Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;
    .locals 1

    .line 38
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->mFileSystemRepository$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    return-object v0
.end method

.method private final getMRecognitionRepository()Lcom/rokid/security/phone/sdk/server/recog/online/repository/RecognitionRepository;
    .locals 1

    .line 37
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->mRecognitionRepository$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/recog/online/repository/RecognitionRepository;

    return-object v0
.end method

.method private final parseMessage(Ljava/lang/String;)V
    .locals 8
    .param p1, "msg"    # Ljava/lang/String;

    .line 62
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const-string v1, "Online_Rec_Action"

    move-object v2, v1

    check-cast v2, Ljava/lang/CharSequence;

    const/4 v3, 0x2

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static {v0, v2, v5, v3, v4}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 63
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 64
    .local v0, "jsonObject":Lorg/json/JSONObject;
    const-string/jumbo v2, "type"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 65
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "msg = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 66
    const-string v1, "extra"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 67
    .local v1, "extraJson":Ljava/lang/String;
    move-object v2, v1

    check-cast v2, Ljava/lang/CharSequence;

    if-eqz v2, :cond_0

    invoke-interface {v2}, Ljava/lang/CharSequence;->length()I

    move-result v2

    if-nez v2, :cond_1

    :cond_0
    const/4 v5, 0x1

    :cond_1
    if-nez v5, :cond_2

    .line 68
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2, v1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 69
    .local v2, "extraJsonObject":Lorg/json/JSONObject;
    const-string v3, "methodName"

    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 70
    .local v3, "methodName":Ljava/lang/String;
    nop

    .line 71
    const-string v4, "request_recog_face"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 72
    sget-object v4, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v4}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v4

    const-class v5, Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;

    invoke-virtual {v4, v1, v5}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;

    .line 73
    .local v4, "extra":Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;
    iget-object v5, p0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, " extra = "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 74
    if-eqz v4, :cond_2

    .line 75
    invoke-direct {p0, v4}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->recognizeFace(Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;)V

    .line 83
    .end local v0    # "jsonObject":Lorg/json/JSONObject;
    .end local v1    # "extraJson":Ljava/lang/String;
    .end local v2    # "extraJsonObject":Lorg/json/JSONObject;
    .end local v3    # "methodName":Ljava/lang/String;
    .end local v4    # "extra":Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;
    :cond_2
    return-void
.end method

.method private final recognizeFace(Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;)V
    .locals 6
    .param p1, "extra"    # Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;

    .line 107
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getDefaultScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v0

    new-instance v1, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;

    const/4 v2, 0x0

    invoke-direct {v1, p0, p1, v2}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$recognizeFace$1;-><init>(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;Lkotlin/coroutines/Continuation;)V

    move-object v3, v1

    check-cast v3, Lkotlin/jvm/functions/Function2;

    const/4 v4, 0x3

    const/4 v5, 0x0

    const/4 v1, 0x0

    invoke-static/range {v0 .. v5}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 197
    return-void
.end method

.method private final sendRecogFaceResponseMsg(ZLcom/rokid/security/sdk/base/common/outside/RecognizePersonInfo;Ljava/lang/String;I)V
    .locals 10
    .param p1, "isSuccess"    # Z
    .param p2, "personInfo"    # Lcom/rokid/security/sdk/base/common/outside/RecognizePersonInfo;
    .param p3, "errorMsg"    # Ljava/lang/String;
    .param p4, "errorCode"    # I

    .line 200
    nop

    .line 201
    :try_start_0
    new-instance v0, Lcom/rokid/security/sdk/base/common/RecogFaceResponseExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/RecogFaceResponseExtra;-><init>()V

    move-object v1, v0

    .local v1, "$this$sendRecogFaceResponseMsg_u24lambda_u241":Lcom/rokid/security/sdk/base/common/RecogFaceResponseExtra;
    const/4 v2, 0x0

    .line 202
    .local v2, "$i$a$-apply-OnlineRecManager$sendRecogFaceResponseMsg$recogFaceResponseExtra$1":I
    const-string v3, "recog_face_response"

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/RecogFaceResponseExtra;->setMethodName(Ljava/lang/String;)V

    .line 203
    invoke-virtual {v1, p1}, Lcom/rokid/security/sdk/base/common/RecogFaceResponseExtra;->setSuccess(Z)V

    .line 204
    if-eqz p2, :cond_0

    move-object v3, p2

    .line 227
    .local v3, "it":Lcom/rokid/security/sdk/base/common/outside/RecognizePersonInfo;
    const/4 v4, 0x0

    .line 204
    .local v4, "$i$a$-let-OnlineRecManager$sendRecogFaceResponseMsg$recogFaceResponseExtra$1$1":I
    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/RecogFaceResponseExtra;->setPersonInfo(Lcom/rokid/security/sdk/base/common/outside/RecognizePersonInfo;)V

    .line 205
    .end local v3    # "it":Lcom/rokid/security/sdk/base/common/outside/RecognizePersonInfo;
    .end local v4    # "$i$a$-let-OnlineRecManager$sendRecogFaceResponseMsg$recogFaceResponseExtra$1$1":I
    :cond_0
    invoke-virtual {v1, p3}, Lcom/rokid/security/sdk/base/common/RecogFaceResponseExtra;->setErrorMsg(Ljava/lang/String;)V

    .line 206
    invoke-virtual {v1, p4}, Lcom/rokid/security/sdk/base/common/RecogFaceResponseExtra;->setErrorCode(I)V

    .line 207
    nop

    .line 201
    .end local v1    # "$this$sendRecogFaceResponseMsg_u24lambda_u241":Lcom/rokid/security/sdk/base/common/RecogFaceResponseExtra;
    .end local v2    # "$i$a$-apply-OnlineRecManager$sendRecogFaceResponseMsg$recogFaceResponseExtra$1":I
    nop

    .line 208
    .local v0, "recogFaceResponseExtra":Lcom/rokid/security/sdk/base/common/RecogFaceResponseExtra;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 209
    .local v1, "extra":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v3, "Online_Rec_Action"

    const-string v4, "extra"

    invoke-static {v1, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v8, 0x1c

    const/4 v9, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v4, v1

    invoke-static/range {v2 .. v9}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v0    # "recogFaceResponseExtra":Lcom/rokid/security/sdk/base/common/RecogFaceResponseExtra;
    .end local v1    # "extra":Ljava/lang/String;
    goto :goto_0

    .line 210
    :catch_0
    move-exception v0

    .line 211
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 213
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method static synthetic sendRecogFaceResponseMsg$default(Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;ZLcom/rokid/security/sdk/base/common/outside/RecognizePersonInfo;Ljava/lang/String;IILjava/lang/Object;)V
    .locals 0

    .line 199
    and-int/lit8 p6, p5, 0x2

    if-eqz p6, :cond_0

    const/4 p2, 0x0

    :cond_0
    and-int/lit8 p6, p5, 0x4

    if-eqz p6, :cond_1

    const-string p3, ""

    :cond_1
    and-int/lit8 p5, p5, 0x8

    if-eqz p5, :cond_2

    const/4 p4, 0x0

    :cond_2
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->sendRecogFaceResponseMsg(ZLcom/rokid/security/sdk/base/common/outside/RecognizePersonInfo;Ljava/lang/String;I)V

    return-void
.end method


# virtual methods
.method public final init()V
    .locals 2

    .line 86
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$mInterMessageListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->addInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V

    .line 101
    return-void
.end method

.method public final release()V
    .locals 2

    .line 220
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->mRecProvider:Lcom/rokid/security/phone/sdk/api/recog/online/api/IRecProvider;

    .line 221
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->dataMap:Lcom/rokid/security/phone/sdk/server/common/FixedSizeMap;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/common/FixedSizeMap;->clear()V

    .line 222
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager$mInterMessageListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->removeInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V

    .line 223
    return-void
.end method

.method public final setRecProvider(Lcom/rokid/security/phone/sdk/api/recog/online/api/IRecProvider;)V
    .locals 0
    .param p1, "recProvider"    # Lcom/rokid/security/phone/sdk/api/recog/online/api/IRecProvider;

    .line 216
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/recog/online/OnlineRecManager;->mRecProvider:Lcom/rokid/security/phone/sdk/api/recog/online/api/IRecProvider;

    .line 217
    return-void
.end method
