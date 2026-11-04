.class public final Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;
.super Ljava/lang/Object;
.source "OfflineRecgManger.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nOfflineRecgManger.kt\nKotlin\n*S Kotlin\n*F\n+ 1 OfflineRecgManger.kt\ncom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n+ 3 CancellableContinuation.kt\nkotlinx/coroutines/CancellableContinuationKt\n*L\n1#1,361:1\n1#2:362\n314#3,11:363\n*S KotlinDebug\n*F\n+ 1 OfflineRecgManger.kt\ncom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger\n*L\n231#1:363,11\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000]\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0011\n\u0002\u0010 \n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0003*\u0001\u0008\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0010\u0010\u000e\u001a\u00020\u000f2\u0006\u0010\u0010\u001a\u00020\u0011H\u0002J)\u0010\u0012\u001a\u00020\u00132\u0006\u0010\u0014\u001a\u00020\u00042\u0006\u0010\u0015\u001a\u00020\u00162\u0006\u0010\u0010\u001a\u00020\u0011H\u0082@\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010\u0017J9\u0010\u0018\u001a\u00020\u00132\u0006\u0010\u0019\u001a\u00020\u00042\u0006\u0010\u001a\u001a\u00020\u00042\u0006\u0010\u001b\u001a\u00020\u00162\u0006\u0010\u001c\u001a\u00020\u00042\u0006\u0010\u0014\u001a\u00020\u0004H\u0086@\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010\u001dJ\u0010\u0010\u001e\u001a\u00020\u000f2\u0006\u0010\u001f\u001a\u00020\u0004H\u0002J\u0010\u0010 \u001a\u00020\u000f2\u0006\u0010\u0010\u001a\u00020\u0011H\u0002J\u0006\u0010!\u001a\u00020\u000fJ\u0010\u0010\"\u001a\u00020\u000f2\u0006\u0010#\u001a\u00020\u0004H\u0002J\u0006\u0010$\u001a\u00020\u000fJF\u0010%\u001a\u00020\u000f2\u0006\u0010&\u001a\u00020\u00132\u0006\u0010\u001c\u001a\u00020\u00042\u0006\u0010\u0014\u001a\u00020\u00042\u0010\u0008\u0002\u0010\'\u001a\n\u0012\u0004\u0012\u00020\u0016\u0018\u00010(2\u0008\u0008\u0002\u0010)\u001a\u00020*2\u0008\u0008\u0002\u0010+\u001a\u00020\u0004H\u0002J\u001e\u0010,\u001a\u00020\u000f2\u0008\u0008\u0002\u0010&\u001a\u00020\u00132\n\u0008\u0002\u0010-\u001a\u0004\u0018\u00010.H\u0002J\u0010\u0010/\u001a\u00020\u000f2\u0008\u00100\u001a\u0004\u0018\u00010\u000bR\u000e\u0010\u0003\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0007\u001a\u00020\u0008X\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\tR\u0010\u0010\n\u001a\u0004\u0018\u00010\u000bX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000c\u001a\u00020\rX\u0082\u000e\u00a2\u0006\u0002\n\u0000\u0082\u0002\u0004\n\u0002\u0008\u0019\u00a8\u00061"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;",
        "",
        "()V",
        "TAG",
        "",
        "mGson",
        "Lcom/google/gson/Gson;",
        "mInterMessageListener",
        "com/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$mInterMessageListener$1",
        "Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$mInterMessageListener$1;",
        "mRecProvider",
        "Lcom/rokid/security/phone/sdk/api/recog/offline/api/IRecProvider;",
        "mRepository",
        "Lcom/rokid/security/phone/sdk/server/recog/offline/repository/OfflineRecRepository;",
        "checkUpdateVersion",
        "",
        "extra",
        "Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;",
        "checkVersion",
        "",
        "sceneId",
        "item",
        "Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;",
        "(Ljava/lang/String;Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;",
        "downloadLibBin",
        "url",
        "filePath",
        "libInfo",
        "sn",
        "(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;Ljava/lang/String;Ljava/lang/String;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;",
        "getPersonnelInfo",
        "personnelId",
        "getPersonnelLib",
        "init",
        "parseMessage",
        "msg",
        "release",
        "sendCheckResponse",
        "isSuccess",
        "libList",
        "",
        "errorCode",
        "",
        "errorMessage",
        "sendRequestPersonInfoResponse",
        "personnelInfo",
        "Lcom/rokid/security/sdk/base/common/outside/PersonnelInfo;",
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


# static fields
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;

.field private static final TAG:Ljava/lang/String; = "OfflineRecgManger"

.field private static mGson:Lcom/google/gson/Gson;

.field private static final mInterMessageListener:Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$mInterMessageListener$1;

.field private static mRecProvider:Lcom/rokid/security/phone/sdk/api/recog/offline/api/IRecProvider;

.field private static mRepository:Lcom/rokid/security/phone/sdk/server/recog/offline/repository/OfflineRecRepository;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;

    .line 42
    new-instance v0, Lcom/rokid/security/phone/sdk/server/recog/offline/repository/OfflineRecRepository;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/recog/offline/repository/OfflineRecRepository;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->mRepository:Lcom/rokid/security/phone/sdk/server/recog/offline/repository/OfflineRecRepository;

    .line 43
    new-instance v0, Lcom/google/gson/Gson;

    invoke-direct {v0}, Lcom/google/gson/Gson;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->mGson:Lcom/google/gson/Gson;

    .line 45
    new-instance v0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$mInterMessageListener$1;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$mInterMessageListener$1;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$mInterMessageListener$1;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 39
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static final synthetic access$checkVersion(Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;
    .param p1, "sceneId"    # Ljava/lang/String;
    .param p2, "item"    # Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;
    .param p3, "extra"    # Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;
    .param p4, "$completion"    # Lkotlin/coroutines/Continuation;

    .line 39
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->checkVersion(Ljava/lang/String;Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$getMRecProvider$p()Lcom/rokid/security/phone/sdk/api/recog/offline/api/IRecProvider;
    .locals 1

    .line 39
    sget-object v0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->mRecProvider:Lcom/rokid/security/phone/sdk/api/recog/offline/api/IRecProvider;

    return-object v0
.end method

.method public static final synthetic access$getMRepository$p()Lcom/rokid/security/phone/sdk/server/recog/offline/repository/OfflineRecRepository;
    .locals 1

    .line 39
    sget-object v0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->mRepository:Lcom/rokid/security/phone/sdk/server/recog/offline/repository/OfflineRecRepository;

    return-object v0
.end method

.method public static final synthetic access$parseMessage(Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;
    .param p1, "msg"    # Ljava/lang/String;

    .line 39
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->parseMessage(Ljava/lang/String;)V

    return-void
.end method

.method public static final synthetic access$sendRequestPersonInfoResponse(Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;ZLcom/rokid/security/sdk/base/common/outside/PersonnelInfo;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;
    .param p1, "isSuccess"    # Z
    .param p2, "personnelInfo"    # Lcom/rokid/security/sdk/base/common/outside/PersonnelInfo;

    .line 39
    invoke-direct {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->sendRequestPersonInfoResponse(ZLcom/rokid/security/sdk/base/common/outside/PersonnelInfo;)V

    return-void
.end method

.method private final checkUpdateVersion(Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;)V
    .locals 0
    .param p1, "extra"    # Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;

    .line 136
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->getPersonnelLib(Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;)V

    .line 137
    return-void
.end method

.method private final checkVersion(Ljava/lang/String;Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 25
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;",
            "Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Ljava/lang/Boolean;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    move-object/from16 v0, p4

    instance-of v1, v0, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$checkVersion$1;

    if-eqz v1, :cond_0

    move-object v1, v0

    check-cast v1, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$checkVersion$1;

    iget v2, v1, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$checkVersion$1;->label:I

    const/high16 v3, -0x80000000

    and-int/2addr v2, v3

    if-eqz v2, :cond_0

    iget v0, v1, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$checkVersion$1;->label:I

    sub-int/2addr v0, v3

    iput v0, v1, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$checkVersion$1;->label:I

    move-object v0, v1

    move-object/from16 v2, p0

    goto :goto_0

    :cond_0
    new-instance v1, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$checkVersion$1;

    move-object/from16 v2, p0

    invoke-direct {v1, v2, v0}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$checkVersion$1;-><init>(Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;Lkotlin/coroutines/Continuation;)V

    move-object v0, v1

    .local v1, "$continuation":Lkotlin/coroutines/Continuation;
    :goto_0
    iget-object v10, v1, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$checkVersion$1;->result:Ljava/lang/Object;

    .local v10, "$result":Ljava/lang/Object;
    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v11

    .line 181
    iget v0, v1, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$checkVersion$1;->label:I

    const/4 v13, 0x1

    packed-switch v0, :pswitch_data_0

    .end local v1    # "$continuation":Lkotlin/coroutines/Continuation;
    .end local v10    # "$result":Ljava/lang/Object;
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .restart local v1    # "$continuation":Lkotlin/coroutines/Continuation;
    .restart local v10    # "$result":Ljava/lang/Object;
    :pswitch_0
    iget-object v0, v1, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$checkVersion$1;->L$1:Ljava/lang/Object;

    check-cast v0, Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;

    .local v0, "extra":Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;
    iget-object v3, v1, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$checkVersion$1;->L$0:Ljava/lang/Object;

    check-cast v3, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;

    .local v3, "this":Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;
    invoke-static {v10}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v15, v0

    move-object/from16 v16, v3

    move-object v0, v10

    const/4 v12, 0x0

    goto/16 :goto_d

    .end local v0    # "extra":Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;
    .end local v3    # "this":Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;
    :pswitch_1
    invoke-static {v10}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object/from16 v14, p0

    .local v14, "this":Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;
    move-object/from16 v6, p2

    .local v6, "item":Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;
    move-object/from16 v8, p1

    .local v8, "sceneId":Ljava/lang/String;
    move-object/from16 v15, p3

    .line 182
    .local v15, "extra":Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;
    invoke-virtual {v15}, Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;->getLibList()Ljava/util/List;

    move-result-object v0

    check-cast v0, Ljava/util/Collection;

    if-eqz v0, :cond_2

    invoke-interface {v0}, Ljava/util/Collection;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    goto :goto_1

    :cond_1
    const/4 v0, 0x0

    goto :goto_2

    :cond_2
    :goto_1
    move v0, v13

    :goto_2
    const-string v3, "OfflineRecgManger"

    if-nez v0, :cond_6

    .line 185
    invoke-virtual {v15}, Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;->getLibList()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_5

    check-cast v0, Ljava/lang/Iterable;

    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_3
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_4

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    move-object v7, v5

    check-cast v7, Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;

    .line 362
    .local v7, "it":Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;
    const/4 v9, 0x0

    .line 185
    .local v9, "$i$a$-find-OfflineRecgManger$checkVersion$info$1":I
    invoke-virtual {v6}, Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;->getPersonnelLibraryId()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v7}, Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;->getPersonnelLibraryId()Ljava/lang/String;

    move-result-object v4

    invoke-static {v12, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v4

    .end local v7    # "it":Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;
    .end local v9    # "$i$a$-find-OfflineRecgManger$checkVersion$info$1":I
    if-eqz v4, :cond_3

    goto :goto_3

    :cond_4
    const/4 v5, 0x0

    :goto_3
    check-cast v5, Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;

    goto :goto_4

    :cond_5
    const/4 v5, 0x0

    :goto_4
    move-object v0, v5

    .line 186
    .local v0, "info":Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;
    if-eqz v0, :cond_6

    .line 187
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "checkVersion "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v6}, Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;->getLibVersion()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "  "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;->getLibVersion()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 188
    nop

    .line 189
    :try_start_0
    invoke-virtual {v6}, Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;->getLibVersion()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v4

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;->getLibVersion()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v5

    .end local v0    # "info":Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;
    if-gt v4, v5, :cond_6

    .line 192
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6}, Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;->getPersonnelLibraryId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v4, " Version \u4e00\u81f4\u4e0d\u7528\u66f4\u65b0"

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v3, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 193
    invoke-static {v13}, Lkotlin/coroutines/jvm/internal/Boxing;->boxBoolean(Z)Ljava/lang/Boolean;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 195
    :catch_0
    move-exception v0

    .line 196
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 203
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_6
    invoke-virtual {v6}, Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;->getBinFileUrl()Ljava/lang/String;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    if-eqz v0, :cond_8

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v0

    if-nez v0, :cond_7

    goto :goto_5

    :cond_7
    const/4 v0, 0x0

    goto :goto_6

    :cond_8
    :goto_5
    move v0, v13

    :goto_6
    if-nez v0, :cond_14

    invoke-virtual {v6}, Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;->getBinFileName()Ljava/lang/String;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    if-eqz v0, :cond_a

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v0

    if-nez v0, :cond_9

    goto :goto_7

    :cond_9
    const/4 v0, 0x0

    goto :goto_8

    :cond_a
    :goto_7
    move v0, v13

    :goto_8
    if-nez v0, :cond_14

    .line 205
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v4

    const/4 v5, 0x0

    invoke-virtual {v4, v5}, Landroid/app/Application;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v4

    if-eqz v4, :cond_b

    invoke-virtual {v4}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v4

    goto :goto_9

    :cond_b
    move-object v4, v5

    :goto_9
    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v4, "/feature/"

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v15}, Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;->getSn()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v4, 0x2f

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 204
    nop

    .line 206
    .local v0, "dir":Ljava/lang/String;
    new-instance v5, Ljava/io/File;

    invoke-direct {v5, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5}, Ljava/io/File;->exists()Z

    move-result v5

    if-nez v5, :cond_c

    .line 207
    new-instance v5, Ljava/io/File;

    invoke-direct {v5, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5}, Ljava/io/File;->mkdirs()Z

    .line 209
    :cond_c
    sget-object v5, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v5}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getMethodProfix()Ljava/lang/String;

    move-result-object v5

    .line 210
    .local v5, "prefix":Ljava/lang/String;
    invoke-virtual {v6}, Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;->getBinFileUrl()Ljava/lang/String;

    move-result-object v7

    .line 211
    .local v7, "binFilePath":Ljava/lang/String;
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, " binFilePath :"

    invoke-virtual {v9, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    filled-new-array {v9}, [Ljava/lang/Object;

    move-result-object v9

    invoke-static {v3, v9}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 212
    move-object v9, v5

    check-cast v9, Ljava/lang/CharSequence;

    if-eqz v9, :cond_e

    invoke-interface {v9}, Ljava/lang/CharSequence;->length()I

    move-result v9

    if-nez v9, :cond_d

    goto :goto_a

    :cond_d
    const/4 v9, 0x0

    goto :goto_b

    :cond_e
    :goto_a
    move v9, v13

    :goto_b
    if-nez v9, :cond_f

    .line 213
    .end local v7    # "binFilePath":Ljava/lang/String;
    nop

    .end local v5    # "prefix":Ljava/lang/String;
    new-array v7, v13, [C

    const/4 v12, 0x0

    aput-char v4, v7, v12

    invoke-static {v5, v7}, Lkotlin/text/StringsKt;->trim(Ljava/lang/String;[C)Ljava/lang/String;

    move-result-object v5

    .line 214
    .local v5, "cleanPrefix":Ljava/lang/String;
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v6}, Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;->getBinFileUrl()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    .line 215
    .restart local v7    # "binFilePath":Ljava/lang/String;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, " has config prefix , new binFilePath : "

    invoke-virtual {v4, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_c

    .line 212
    .local v5, "prefix":Ljava/lang/String;
    :cond_f
    const/4 v12, 0x0

    .line 217
    .end local v5    # "prefix":Ljava/lang/String;
    :goto_c
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v4, Lcom/rokid/security/sdk/ability/net/UrlConfig;->INSTANCE:Lcom/rokid/security/sdk/ability/net/UrlConfig;

    invoke-virtual {v4}, Lcom/rokid/security/sdk/ability/net/UrlConfig;->getHostUrl()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v16

    .line 218
    .end local v7    # "binFilePath":Ljava/lang/String;
    .local v16, "url":Ljava/lang/String;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v6}, Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;->getBinFileName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 219
    .local v0, "filePath":Ljava/lang/String;
    invoke-static {v0}, Lcom/blankj/utilcode/util/FileUtils;->delete(Ljava/lang/String;)Z

    .line 220
    invoke-virtual {v15}, Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;->getSn()Ljava/lang/String;

    move-result-object v7

    iput-object v14, v1, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$checkVersion$1;->L$0:Ljava/lang/Object;

    iput-object v15, v1, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$checkVersion$1;->L$1:Ljava/lang/Object;

    iput v13, v1, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$checkVersion$1;->label:I

    move-object v3, v14

    move-object/from16 v4, v16

    move-object v5, v0

    move-object v9, v1

    invoke-virtual/range {v3 .. v9}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->downloadLibBin(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;Ljava/lang/String;Ljava/lang/String;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    .end local v0    # "filePath":Ljava/lang/String;
    .end local v6    # "item":Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;
    .end local v8    # "sceneId":Ljava/lang/String;
    .end local v16    # "url":Ljava/lang/String;
    if-ne v0, v11, :cond_10

    .line 181
    return-object v11

    .line 220
    :cond_10
    move-object/from16 v16, v14

    .end local v14    # "this":Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;
    .local v16, "this":Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;
    :goto_d
    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    .line 221
    .local v0, "ret":Z
    if-nez v0, :cond_12

    .line 222
    if-eqz v0, :cond_11

    move/from16 v17, v13

    goto :goto_e

    :cond_11
    move/from16 v17, v12

    .end local v16    # "this":Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;
    :goto_e
    invoke-virtual {v15}, Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;->getSn()Ljava/lang/String;

    move-result-object v18

    invoke-virtual {v15}, Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;->getSceneId()Ljava/lang/String;

    move-result-object v19

    const/16 v23, 0x38

    const/16 v24, 0x0

    const/16 v20, 0x0

    const/16 v21, 0x0

    const/16 v22, 0x0

    invoke-static/range {v16 .. v24}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->sendCheckResponse$default(Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;ZLjava/lang/String;Ljava/lang/String;Ljava/util/List;ILjava/lang/String;ILjava/lang/Object;)V

    .line 224
    .end local v15    # "extra":Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;
    :cond_12
    if-eqz v0, :cond_13

    move v12, v13

    nop

    .end local v0    # "ret":Z
    :cond_13
    invoke-static {v12}, Lkotlin/coroutines/jvm/internal/Boxing;->boxBoolean(Z)Ljava/lang/Boolean;

    move-result-object v0

    return-object v0

    .line 226
    :cond_14
    invoke-static {v13}, Lkotlin/coroutines/jvm/internal/Boxing;->boxBoolean(Z)Ljava/lang/Boolean;

    move-result-object v0

    return-object v0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private final getPersonnelInfo(Ljava/lang/String;)V
    .locals 6
    .param p1, "personnelId"    # Ljava/lang/String;

    .line 309
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getDefaultScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v0

    new-instance v1, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelInfo$1;

    const/4 v2, 0x0

    invoke-direct {v1, p1, v2}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelInfo$1;-><init>(Ljava/lang/String;Lkotlin/coroutines/Continuation;)V

    move-object v3, v1

    check-cast v3, Lkotlin/jvm/functions/Function2;

    const/4 v4, 0x3

    const/4 v5, 0x0

    const/4 v1, 0x0

    invoke-static/range {v0 .. v5}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 327
    return-void
.end method

.method private final getPersonnelLib(Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;)V
    .locals 18
    .param p1, "extra"    # Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;

    .line 140
    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;->getSceneId()Ljava/lang/String;

    move-result-object v6

    .line 141
    .local v6, "sceneId":Ljava/lang/String;
    const/4 v0, 0x1

    new-array v1, v0, [Ljava/lang/String;

    const/4 v2, 0x0

    aput-object v6, v1, v2

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->arrayListOf([Ljava/lang/Object;)Ljava/util/ArrayList;

    move-result-object v7

    .line 142
    .local v7, "libScenes":Ljava/util/ArrayList;
    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;->getSn()Ljava/lang/String;

    move-result-object v8

    .line 144
    .local v8, "sn":Ljava/lang/String;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getPersonnelLib: sceneId = "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, ", sn = "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "  libList = "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;->getLibList()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    const-string v3, "OfflineRecgManger"

    invoke-static {v3, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 145
    move-object v1, v8

    check-cast v1, Ljava/lang/CharSequence;

    if-eqz v1, :cond_1

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v1

    if-nez v1, :cond_0

    goto :goto_0

    :cond_0
    move v0, v2

    :cond_1
    :goto_0
    if-eqz v0, :cond_2

    .line 146
    const-string v0, "getPersonnelLib sn = null "

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v3, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 147
    invoke-virtual/range {p1 .. p1}, Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;->getSceneId()Ljava/lang/String;

    move-result-object v12

    const/16 v16, 0x8

    const/16 v17, 0x0

    const/4 v10, 0x0

    const-string v11, ""

    const/4 v13, 0x0

    const/4 v14, -0x2

    const-string/jumbo v15, "\u672a\u83b7\u53d6\u5230 sn"

    move-object/from16 v9, p0

    invoke-static/range {v9 .. v17}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->sendCheckResponse$default(Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;ZLjava/lang/String;Ljava/lang/String;Ljava/util/List;ILjava/lang/String;ILjava/lang/Object;)V

    .line 148
    return-void

    .line 151
    :cond_2
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getDefaultScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v9

    new-instance v10, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;

    const/4 v5, 0x0

    move-object v0, v10

    move-object v1, v6

    move-object/from16 v2, p1

    move-object v3, v8

    move-object v4, v7

    invoke-direct/range {v0 .. v5}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$getPersonnelLib$1;-><init>(Ljava/lang/String;Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;Ljava/lang/String;Ljava/util/ArrayList;Lkotlin/coroutines/Continuation;)V

    move-object v3, v10

    check-cast v3, Lkotlin/jvm/functions/Function2;

    const/4 v4, 0x3

    const/4 v1, 0x0

    const/4 v2, 0x0

    move-object v0, v9

    invoke-static/range {v0 .. v5}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 179
    return-void
.end method

.method private final parseMessage(Ljava/lang/String;)V
    .locals 8
    .param p1, "msg"    # Ljava/lang/String;

    .line 87
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const-string v1, "Offline_Rec_Action"

    move-object v2, v1

    check-cast v2, Ljava/lang/CharSequence;

    const/4 v3, 0x2

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static {v0, v2, v5, v3, v4}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    .line 88
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 89
    .local v0, "jsonObject":Lorg/json/JSONObject;
    const-string/jumbo v2, "type"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_5

    .line 90
    const-string v1, "extra"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 91
    .local v2, "extraJson":Ljava/lang/String;
    move-object v3, v2

    check-cast v3, Ljava/lang/CharSequence;

    if-eqz v3, :cond_0

    invoke-interface {v3}, Ljava/lang/CharSequence;->length()I

    move-result v3

    if-nez v3, :cond_1

    :cond_0
    const/4 v5, 0x1

    :cond_1
    if-nez v5, :cond_5

    .line 92
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3, v2}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 93
    .local v3, "extraJsonObject":Lorg/json/JSONObject;
    const-string v4, "extraType"

    invoke-virtual {v3, v4}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 94
    .local v4, "extraType":Ljava/lang/String;
    nop

    .line 95
    const-string v5, "CheckUpdate"

    invoke-static {v4, v5}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v5

    const-string v6, "OfflineRecgManger"

    if-eqz v5, :cond_3

    .line 96
    sget-object v5, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->mGson:Lcom/google/gson/Gson;

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-class v7, Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;

    invoke-virtual {v5, v1, v7}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;

    .line 97
    .local v1, "extra":Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;
    if-eqz v1, :cond_2

    .line 98
    invoke-direct {p0, v1}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->checkUpdateVersion(Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;)V

    goto :goto_0

    .line 100
    :cond_2
    const-string v5, "CheckUpdateVersionExtra = null"

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v6, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .end local v1    # "extra":Lcom/rokid/security/sdk/base/common/CheckUpdateVersionExtra;
    goto :goto_0

    .line 104
    :cond_3
    const-string v5, "RequestPersonInfo"

    invoke-static {v4, v5}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_5

    .line 105
    sget-object v5, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->mGson:Lcom/google/gson/Gson;

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-class v7, Lcom/rokid/security/sdk/base/common/RequestPersonInfoExtra;

    invoke-virtual {v5, v1, v7}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/rokid/security/sdk/base/common/RequestPersonInfoExtra;

    .line 106
    .local v1, "extra":Lcom/rokid/security/sdk/base/common/RequestPersonInfoExtra;
    if-eqz v1, :cond_4

    .line 107
    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/RequestPersonInfoExtra;->getPersonnelId()Ljava/lang/String;

    move-result-object v5

    invoke-direct {p0, v5}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->getPersonnelInfo(Ljava/lang/String;)V

    goto :goto_0

    .line 109
    :cond_4
    const-string v5, "RequestPersonInfoExtra = null"

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v6, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 116
    .end local v0    # "jsonObject":Lorg/json/JSONObject;
    .end local v1    # "extra":Lcom/rokid/security/sdk/base/common/RequestPersonInfoExtra;
    .end local v2    # "extraJson":Ljava/lang/String;
    .end local v3    # "extraJsonObject":Lorg/json/JSONObject;
    .end local v4    # "extraType":Ljava/lang/String;
    :cond_5
    :goto_0
    return-void
.end method

.method private final sendCheckResponse(ZLjava/lang/String;Ljava/lang/String;Ljava/util/List;ILjava/lang/String;)V
    .locals 17
    .param p1, "isSuccess"    # Z
    .param p2, "sn"    # Ljava/lang/String;
    .param p3, "sceneId"    # Ljava/lang/String;
    .param p4, "libList"    # Ljava/util/List;
    .param p5, "errorCode"    # I
    .param p6, "errorMessage"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(Z",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;",
            ">;I",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .line 330
    move-object/from16 v0, p4

    new-instance v1, Lcom/rokid/security/sdk/base/common/CheckResponseExtra;

    invoke-direct {v1}, Lcom/rokid/security/sdk/base/common/CheckResponseExtra;-><init>()V

    move-object v2, v1

    .local v2, "$this$sendCheckResponse_u24lambda_u243":Lcom/rokid/security/sdk/base/common/CheckResponseExtra;
    const/4 v3, 0x0

    .line 331
    .local v3, "$i$a$-apply-OfflineRecgManger$sendCheckResponse$extra$1":I
    const-string v4, "Check_Lib_Response"

    invoke-virtual {v2, v4}, Lcom/rokid/security/sdk/base/common/CheckResponseExtra;->setMethodName(Ljava/lang/String;)V

    .line 332
    move-object/from16 v4, p2

    invoke-virtual {v2, v4}, Lcom/rokid/security/sdk/base/common/CheckResponseExtra;->setSn(Ljava/lang/String;)V

    .line 333
    move-object/from16 v5, p3

    invoke-virtual {v2, v5}, Lcom/rokid/security/sdk/base/common/CheckResponseExtra;->setSceneId(Ljava/lang/String;)V

    .line 334
    move/from16 v6, p1

    invoke-virtual {v2, v6}, Lcom/rokid/security/sdk/base/common/CheckResponseExtra;->setSuccess(Z)V

    .line 335
    if-eqz v0, :cond_0

    move-object/from16 v7, p4

    .line 362
    .local v7, "it":Ljava/util/List;
    const/4 v8, 0x0

    .line 335
    .local v8, "$i$a$-let-OfflineRecgManger$sendCheckResponse$extra$1$1":I
    invoke-virtual {v2, v0}, Lcom/rokid/security/sdk/base/common/CheckResponseExtra;->setLibList(Ljava/util/List;)V

    .line 336
    .end local v7    # "it":Ljava/util/List;
    .end local v8    # "$i$a$-let-OfflineRecgManger$sendCheckResponse$extra$1$1":I
    :cond_0
    move/from16 v7, p5

    invoke-virtual {v2, v7}, Lcom/rokid/security/sdk/base/common/CheckResponseExtra;->setErrorCode(I)V

    .line 337
    move-object/from16 v8, p6

    invoke-virtual {v2, v8}, Lcom/rokid/security/sdk/base/common/CheckResponseExtra;->setErrorMessage(Ljava/lang/String;)V

    .line 338
    nop

    .line 330
    .end local v2    # "$this$sendCheckResponse_u24lambda_u243":Lcom/rokid/security/sdk/base/common/CheckResponseExtra;
    .end local v3    # "$i$a$-apply-OfflineRecgManger$sendCheckResponse$extra$1":I
    nop

    .line 339
    .local v1, "extra":Lcom/rokid/security/sdk/base/common/CheckResponseExtra;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->mGson:Lcom/google/gson/Gson;

    invoke-virtual {v2, v1}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 340
    .local v2, "extraJson":Ljava/lang/String;
    sget-object v9, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v3, "extraJson"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v15, 0x1c

    const/16 v16, 0x0

    const-string v10, "Offline_Rec_Action"

    const/4 v12, 0x0

    const/4 v13, 0x0

    const/4 v14, 0x0

    move-object v11, v2

    invoke-static/range {v9 .. v16}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 341
    return-void
.end method

.method static synthetic sendCheckResponse$default(Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;ZLjava/lang/String;Ljava/lang/String;Ljava/util/List;ILjava/lang/String;ILjava/lang/Object;)V
    .locals 7

    .line 329
    and-int/lit8 p8, p7, 0x8

    if-eqz p8, :cond_0

    const/4 p4, 0x0

    :cond_0
    move-object v4, p4

    and-int/lit8 p4, p7, 0x10

    if-eqz p4, :cond_1

    const/4 p5, 0x0

    :cond_1
    move v5, p5

    and-int/lit8 p4, p7, 0x20

    if-eqz p4, :cond_2

    const-string p6, ""

    :cond_2
    move-object v6, p6

    move-object v0, p0

    move v1, p1

    move-object v2, p2

    move-object v3, p3

    invoke-direct/range {v0 .. v6}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->sendCheckResponse(ZLjava/lang/String;Ljava/lang/String;Ljava/util/List;ILjava/lang/String;)V

    return-void
.end method

.method private final sendRequestPersonInfoResponse(ZLcom/rokid/security/sdk/base/common/outside/PersonnelInfo;)V
    .locals 10
    .param p1, "isSuccess"    # Z
    .param p2, "personnelInfo"    # Lcom/rokid/security/sdk/base/common/outside/PersonnelInfo;

    .line 344
    new-instance v0, Lcom/rokid/security/sdk/base/common/RequestPersonInfoResponseExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/RequestPersonInfoResponseExtra;-><init>()V

    move-object v1, v0

    .local v1, "$this$sendRequestPersonInfoResponse_u24lambda_u245":Lcom/rokid/security/sdk/base/common/RequestPersonInfoResponseExtra;
    const/4 v2, 0x0

    .line 345
    .local v2, "$i$a$-apply-OfflineRecgManger$sendRequestPersonInfoResponse$extra$1":I
    const-string v3, "RequestPersonInfo_Response"

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/RequestPersonInfoResponseExtra;->setMethodName(Ljava/lang/String;)V

    .line 346
    invoke-virtual {v1, p1}, Lcom/rokid/security/sdk/base/common/RequestPersonInfoResponseExtra;->setSuccess(Z)V

    .line 347
    if-eqz p2, :cond_0

    move-object v3, p2

    .line 362
    .local v3, "it":Lcom/rokid/security/sdk/base/common/outside/PersonnelInfo;
    const/4 v4, 0x0

    .line 347
    .local v4, "$i$a$-let-OfflineRecgManger$sendRequestPersonInfoResponse$extra$1$1":I
    invoke-virtual {v1, p2}, Lcom/rokid/security/sdk/base/common/RequestPersonInfoResponseExtra;->setPersonnelInfo(Lcom/rokid/security/sdk/base/common/outside/PersonnelInfo;)V

    .line 349
    .end local v3    # "it":Lcom/rokid/security/sdk/base/common/outside/PersonnelInfo;
    .end local v4    # "$i$a$-let-OfflineRecgManger$sendRequestPersonInfoResponse$extra$1$1":I
    :cond_0
    nop

    .line 344
    .end local v1    # "$this$sendRequestPersonInfoResponse_u24lambda_u245":Lcom/rokid/security/sdk/base/common/RequestPersonInfoResponseExtra;
    .end local v2    # "$i$a$-apply-OfflineRecgManger$sendRequestPersonInfoResponse$extra$1":I
    nop

    .line 350
    .local v0, "extra":Lcom/rokid/security/sdk/base/common/RequestPersonInfoResponseExtra;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->mGson:Lcom/google/gson/Gson;

    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 351
    .local v1, "extraJson":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v3, "extraJson"

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v8, 0x1c

    const/4 v9, 0x0

    const-string v3, "Offline_Rec_Action"

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v4, v1

    invoke-static/range {v2 .. v9}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 352
    return-void
.end method

.method static synthetic sendRequestPersonInfoResponse$default(Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;ZLcom/rokid/security/sdk/base/common/outside/PersonnelInfo;ILjava/lang/Object;)V
    .locals 0

    .line 343
    and-int/lit8 p4, p3, 0x1

    if-eqz p4, :cond_0

    const/4 p1, 0x0

    :cond_0
    and-int/lit8 p3, p3, 0x2

    if-eqz p3, :cond_1

    const/4 p2, 0x0

    :cond_1
    invoke-direct {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->sendRequestPersonInfoResponse(ZLcom/rokid/security/sdk/base/common/outside/PersonnelInfo;)V

    return-void
.end method


# virtual methods
.method public final downloadLibBin(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;Ljava/lang/String;Ljava/lang/String;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 16
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "filePath"    # Ljava/lang/String;
    .param p3, "libInfo"    # Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;
    .param p4, "sn"    # Ljava/lang/String;
    .param p5, "sceneId"    # Ljava/lang/String;
    .param p6, "$completion"    # Lkotlin/coroutines/Continuation;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Ljava/lang/Boolean;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    .line 231
    move-object/from16 v0, p1

    move-object/from16 v7, p2

    const/4 v8, 0x0

    .line 363
    .local v8, "$i$f$suspendCancellableCoroutine":I
    move-object/from16 v9, p6

    .local v9, "uCont$iv":Lkotlin/coroutines/Continuation;
    const/4 v10, 0x0

    .line 364
    .local v10, "$i$a$-suspendCoroutineUninterceptedOrReturn-CancellableContinuationKt$suspendCancellableCoroutine$2$iv":I
    new-instance v1, Lkotlinx/coroutines/CancellableContinuationImpl;

    invoke-static {v9}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->intercepted(Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v2

    const/4 v3, 0x1

    invoke-direct {v1, v2, v3}, Lkotlinx/coroutines/CancellableContinuationImpl;-><init>(Lkotlin/coroutines/Continuation;I)V

    move-object v11, v1

    .line 370
    .local v11, "cancellable$iv":Lkotlinx/coroutines/CancellableContinuationImpl;
    invoke-virtual {v11}, Lkotlinx/coroutines/CancellableContinuationImpl;->initCancellability()V

    .line 371
    move-object v12, v11

    check-cast v12, Lkotlinx/coroutines/CancellableContinuation;

    .local v12, "it":Lkotlinx/coroutines/CancellableContinuation;
    const/4 v13, 0x0

    .line 232
    .local v13, "$i$a$-suspendCancellableCoroutine-OfflineRecgManger$downloadLibBin$2":I
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "downloadLibBin: url = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", filePath = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "OfflineRecgManger"

    invoke-static {v2, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 233
    sget-object v14, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;

    .line 234
    nop

    .line 235
    nop

    .line 236
    new-instance v15, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1;

    move-object v1, v15

    move-object v2, v12

    move-object/from16 v3, p2

    move-object/from16 v4, p3

    move-object/from16 v5, p4

    move-object/from16 v6, p5

    invoke-direct/range {v1 .. v6}, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$downloadLibBin$2$1;-><init>(Lkotlinx/coroutines/CancellableContinuation;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/outside/PersonnelLibInfo;Ljava/lang/String;Ljava/lang/String;)V

    check-cast v15, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$ProgressListener;

    .line 233
    invoke-virtual {v14, v0, v7, v15}, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;->download(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$ProgressListener;)V

    .line 306
    nop

    .line 371
    .end local v12    # "it":Lkotlinx/coroutines/CancellableContinuation;
    .end local v13    # "$i$a$-suspendCancellableCoroutine-OfflineRecgManger$downloadLibBin$2":I
    nop

    .line 372
    invoke-virtual {v11}, Lkotlinx/coroutines/CancellableContinuationImpl;->getResult()Ljava/lang/Object;

    move-result-object v1

    .line 363
    .end local v9    # "uCont$iv":Lkotlin/coroutines/Continuation;
    .end local v10    # "$i$a$-suspendCoroutineUninterceptedOrReturn-CancellableContinuationKt$suspendCancellableCoroutine$2$iv":I
    .end local v11    # "cancellable$iv":Lkotlinx/coroutines/CancellableContinuationImpl;
    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v2

    if-ne v1, v2, :cond_0

    invoke-static/range {p6 .. p6}, Lkotlin/coroutines/jvm/internal/DebugProbesKt;->probeCoroutineSuspended(Lkotlin/coroutines/Continuation;)V

    .line 373
    :cond_0
    nop

    .line 306
    .end local v8    # "$i$f$suspendCancellableCoroutine":I
    return-object v1
.end method

.method public final init()V
    .locals 2

    .line 131
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$mInterMessageListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->addInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V

    .line 132
    return-void
.end method

.method public final release()V
    .locals 2

    .line 359
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger$mInterMessageListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->removeInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V

    .line 360
    return-void
.end method

.method public final setRecProvider(Lcom/rokid/security/phone/sdk/api/recog/offline/api/IRecProvider;)V
    .locals 0
    .param p1, "recProvider"    # Lcom/rokid/security/phone/sdk/api/recog/offline/api/IRecProvider;

    .line 355
    sput-object p1, Lcom/rokid/security/phone/sdk/server/recog/offline/OfflineRecgManger;->mRecProvider:Lcom/rokid/security/phone/sdk/api/recog/offline/api/IRecProvider;

    .line 356
    return-void
.end method
