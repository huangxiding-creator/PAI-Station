.class public final Lcom/rokid/security/phone/sdk/server/coreability/track/RecgEngine;
.super Ljava/lang/Object;
.source "RecgEngine.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000T\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0006\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\u0005\n\u0002\u0010\u0002\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u000e\u0010\u0018\u001a\u00020\u00192\u0006\u0010\u001a\u001a\u00020\u0013J\u0006\u0010\u001b\u001a\u00020\u0019J\u000e\u0010\u001c\u001a\u00020\u00192\u0006\u0010\u001d\u001a\u00020\u001eJ\u000e\u0010\u001f\u001a\u00020\u00192\u0006\u0010\u001d\u001a\u00020 J\u000e\u0010!\u001a\u00020\"2\u0006\u0010\u0012\u001a\u00020\u0013J\u000e\u0010#\u001a\u00020\u00192\u0006\u0010$\u001a\u00020%R\u001a\u0010\u0003\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u000e\u0010\t\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u0010\u0010\n\u001a\u0004\u0018\u00010\u000bX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000c\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u0010\u0010\r\u001a\u0004\u0018\u00010\u000eX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000f\u001a\u00020\u0010X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0011\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u001a\u0010\u0012\u001a\u00020\u0013X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0014\u0010\u0015\"\u0004\u0008\u0016\u0010\u0017\u00a8\u0006&"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/coreability/track/RecgEngine;",
        "",
        "()V",
        "TAG",
        "",
        "getTAG",
        "()Ljava/lang/String;",
        "setTAG",
        "(Ljava/lang/String;)V",
        "VERSION",
        "faceEngine",
        "Lcom/rokid/aicore/api/engines/FaceEngine;",
        "iqaModelName",
        "lprEngine",
        "Lcom/rokid/aicore/api/engines/LPREngine;",
        "mainScope",
        "Lkotlinx/coroutines/CoroutineScope;",
        "recModelName",
        "recogMode",
        "",
        "getRecogMode",
        "()I",
        "setRecogMode",
        "(I)V",
        "changeMode",
        "",
        "mode",
        "destroy",
        "initFaceSdk",
        "callback",
        "Lcom/rokid/aicore/api/callback/face/FaceCallback;",
        "initLprSdk",
        "Lcom/rokid/aicore/api/callback/LPRCallback;",
        "isEnabledRecogMode",
        "",
        "processAsync",
        "recgImageInput",
        "Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;",
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
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/track/RecgEngine;

.field private static TAG:Ljava/lang/String; = null

.field public static final VERSION:Ljava/lang/String; = "128-ncnn"

.field private static faceEngine:Lcom/rokid/aicore/api/engines/FaceEngine;

.field private static final iqaModelName:Ljava/lang/String;

.field private static lprEngine:Lcom/rokid/aicore/api/engines/LPREngine;

.field private static mainScope:Lkotlinx/coroutines/CoroutineScope;

.field private static final recModelName:Ljava/lang/String;

.field private static recogMode:I


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/security/phone/sdk/server/coreability/track/RecgEngine;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/coreability/track/RecgEngine;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/coreability/track/RecgEngine;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/track/RecgEngine;

    .line 22
    const-class v0, Lcom/rokid/security/phone/sdk/server/coreability/track/RecgEngine;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    const-string v1, "RecgEngine::class.java.simpleName"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/coreability/track/RecgEngine;->TAG:Ljava/lang/String;

    .line 25
    const-string v0, "recog-128-rokid"

    sput-object v0, Lcom/rokid/security/phone/sdk/server/coreability/track/RecgEngine;->recModelName:Ljava/lang/String;

    .line 26
    const-string v0, "cnet-iqa-ncnn"

    sput-object v0, Lcom/rokid/security/phone/sdk/server/coreability/track/RecgEngine;->iqaModelName:Ljava/lang/String;

    .line 32
    invoke-static {}, Lkotlinx/coroutines/CoroutineScopeKt;->MainScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/phone/sdk/server/coreability/track/RecgEngine;->mainScope:Lkotlinx/coroutines/CoroutineScope;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final changeMode(I)V
    .locals 4
    .param p1, "mode"    # I

    .line 98
    sput p1, Lcom/rokid/security/phone/sdk/server/coreability/track/RecgEngine;->recogMode:I

    .line 99
    const/4 v0, 0x1

    const/4 v1, 0x0

    packed-switch p1, :pswitch_data_0

    .line 110
    sget-object v0, Lcom/rokid/aicore/api/AIEngine;->Companion:Lcom/rokid/aicore/api/AIEngine$Companion;

    invoke-virtual {v0}, Lcom/rokid/aicore/api/AIEngine$Companion;->getInstance()Lcom/rokid/aicore/api/AIEngine;

    move-result-object v0

    sget-object v2, Lcom/rokid/aicore/api/bean/DetectType;->LPR:Lcom/rokid/aicore/api/bean/DetectType;

    invoke-virtual {v0, v2, v1}, Lcom/rokid/aicore/api/AIEngine;->enable(Lcom/rokid/aicore/api/bean/DetectType;Z)V

    .line 111
    sget-object v0, Lcom/rokid/aicore/api/AIEngine;->Companion:Lcom/rokid/aicore/api/AIEngine$Companion;

    invoke-virtual {v0}, Lcom/rokid/aicore/api/AIEngine$Companion;->getInstance()Lcom/rokid/aicore/api/AIEngine;

    move-result-object v0

    sget-object v2, Lcom/rokid/aicore/api/bean/DetectType;->FACE:Lcom/rokid/aicore/api/bean/DetectType;

    invoke-virtual {v0, v2, v1}, Lcom/rokid/aicore/api/AIEngine;->enable(Lcom/rokid/aicore/api/bean/DetectType;Z)V

    goto :goto_0

    .line 107
    :pswitch_0
    sget-object v1, Lcom/rokid/aicore/api/AIEngine;->Companion:Lcom/rokid/aicore/api/AIEngine$Companion;

    invoke-virtual {v1}, Lcom/rokid/aicore/api/AIEngine$Companion;->getInstance()Lcom/rokid/aicore/api/AIEngine;

    move-result-object v1

    sget-object v2, Lcom/rokid/aicore/api/bean/DetectType;->LPR:Lcom/rokid/aicore/api/bean/DetectType;

    invoke-virtual {v1, v2, v0}, Lcom/rokid/aicore/api/AIEngine;->enable(Lcom/rokid/aicore/api/bean/DetectType;Z)V

    .line 108
    sget-object v1, Lcom/rokid/aicore/api/AIEngine;->Companion:Lcom/rokid/aicore/api/AIEngine$Companion;

    invoke-virtual {v1}, Lcom/rokid/aicore/api/AIEngine$Companion;->getInstance()Lcom/rokid/aicore/api/AIEngine;

    move-result-object v1

    sget-object v2, Lcom/rokid/aicore/api/bean/DetectType;->FACE:Lcom/rokid/aicore/api/bean/DetectType;

    invoke-virtual {v1, v2, v0}, Lcom/rokid/aicore/api/AIEngine;->enable(Lcom/rokid/aicore/api/bean/DetectType;Z)V

    goto :goto_0

    .line 100
    :pswitch_1
    sget-object v2, Lcom/rokid/aicore/api/AIEngine;->Companion:Lcom/rokid/aicore/api/AIEngine$Companion;

    invoke-virtual {v2}, Lcom/rokid/aicore/api/AIEngine$Companion;->getInstance()Lcom/rokid/aicore/api/AIEngine;

    move-result-object v2

    sget-object v3, Lcom/rokid/aicore/api/bean/DetectType;->FACE:Lcom/rokid/aicore/api/bean/DetectType;

    invoke-virtual {v2, v3, v1}, Lcom/rokid/aicore/api/AIEngine;->enable(Lcom/rokid/aicore/api/bean/DetectType;Z)V

    .line 101
    sget-object v1, Lcom/rokid/aicore/api/AIEngine;->Companion:Lcom/rokid/aicore/api/AIEngine$Companion;

    invoke-virtual {v1}, Lcom/rokid/aicore/api/AIEngine$Companion;->getInstance()Lcom/rokid/aicore/api/AIEngine;

    move-result-object v1

    sget-object v2, Lcom/rokid/aicore/api/bean/DetectType;->LPR:Lcom/rokid/aicore/api/bean/DetectType;

    invoke-virtual {v1, v2, v0}, Lcom/rokid/aicore/api/AIEngine;->enable(Lcom/rokid/aicore/api/bean/DetectType;Z)V

    goto :goto_0

    .line 104
    :pswitch_2
    sget-object v2, Lcom/rokid/aicore/api/AIEngine;->Companion:Lcom/rokid/aicore/api/AIEngine$Companion;

    invoke-virtual {v2}, Lcom/rokid/aicore/api/AIEngine$Companion;->getInstance()Lcom/rokid/aicore/api/AIEngine;

    move-result-object v2

    sget-object v3, Lcom/rokid/aicore/api/bean/DetectType;->LPR:Lcom/rokid/aicore/api/bean/DetectType;

    invoke-virtual {v2, v3, v1}, Lcom/rokid/aicore/api/AIEngine;->enable(Lcom/rokid/aicore/api/bean/DetectType;Z)V

    .line 105
    sget-object v1, Lcom/rokid/aicore/api/AIEngine;->Companion:Lcom/rokid/aicore/api/AIEngine$Companion;

    invoke-virtual {v1}, Lcom/rokid/aicore/api/AIEngine$Companion;->getInstance()Lcom/rokid/aicore/api/AIEngine;

    move-result-object v1

    sget-object v2, Lcom/rokid/aicore/api/bean/DetectType;->FACE:Lcom/rokid/aicore/api/bean/DetectType;

    invoke-virtual {v1, v2, v0}, Lcom/rokid/aicore/api/AIEngine;->enable(Lcom/rokid/aicore/api/bean/DetectType;Z)V

    .line 113
    :goto_0
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public final destroy()V
    .locals 1

    .line 120
    sget-object v0, Lcom/rokid/aicore/api/AIEngine;->Companion:Lcom/rokid/aicore/api/AIEngine$Companion;

    invoke-virtual {v0}, Lcom/rokid/aicore/api/AIEngine$Companion;->getInstance()Lcom/rokid/aicore/api/AIEngine;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/aicore/api/AIEngine;->destroy()V

    .line 121
    return-void
.end method

.method public final getRecogMode()I
    .locals 1

    .line 24
    sget v0, Lcom/rokid/security/phone/sdk/server/coreability/track/RecgEngine;->recogMode:I

    return v0
.end method

.method public final getTAG()Ljava/lang/String;
    .locals 1

    .line 22
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/track/RecgEngine;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public final initFaceSdk(Lcom/rokid/aicore/api/callback/face/FaceCallback;)V
    .locals 3
    .param p1, "callback"    # Lcom/rokid/aicore/api/callback/face/FaceCallback;

    const-string v0, "callback"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 58
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/track/RecgEngine;->TAG:Ljava/lang/String;

    const-string v1, "initFaceSdk: start "

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 60
    new-instance v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    sget-object v1, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->kAlgorithmFaceDet:Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    const-string/jumbo v2, "scrfd_500m_kps-opt2"

    invoke-direct {v0, v1, v2}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;-><init>(Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;Ljava/lang/String;)V

    .line 61
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v1

    invoke-virtual {v1}, Landroid/app/Application;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->setAssetsMgr(Landroid/content/res/AssetManager;)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    move-result-object v0

    .line 62
    const/4 v1, 0x5

    invoke-virtual {v0, v1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->setMaxNumDetections(I)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    move-result-object v0

    .line 63
    const/high16 v1, 0x3f000000    # 0.5f

    invoke-virtual {v0, v1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->setDetectScore(F)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    move-result-object v0

    .line 64
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->setDetectInterval(I)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    move-result-object v0

    .line 65
    const/4 v2, 0x1

    invoke-virtual {v0, v2}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->setHasPts(Z)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    move-result-object v0

    .line 66
    const/high16 v2, 0x420c0000    # 35.0f

    invoke-virtual {v0, v2}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->setIqaThreshold(F)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    move-result-object v0

    .line 67
    const/high16 v2, 0x42a20000    # 81.0f

    invoke-virtual {v0, v2}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->setRecThreshold(F)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    move-result-object v0

    .line 68
    sget-object v2, Lcom/rokid/security/phone/sdk/server/coreability/track/RecgEngine;->recModelName:Ljava/lang/String;

    invoke-virtual {v0, v2}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->setRecModelName(Ljava/lang/String;)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    move-result-object v0

    .line 69
    sget-object v2, Lcom/rokid/security/phone/sdk/server/coreability/track/RecgEngine;->iqaModelName:Ljava/lang/String;

    invoke-virtual {v0, v2}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->setIqaModelName(Ljava/lang/String;)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    move-result-object v0

    .line 70
    invoke-virtual {v0, v1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->setSkipTrack(Z)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    move-result-object v0

    .line 72
    invoke-virtual {v0}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->build()Lcom/rokid/aicore/ncnn/bean/MotConfig;

    move-result-object v0

    .line 59
    nop

    .line 73
    .local v0, "faceConfig":Lcom/rokid/aicore/ncnn/bean/MotConfig;
    sget-object v1, Lcom/rokid/aicore/api/AIEngine;->Companion:Lcom/rokid/aicore/api/AIEngine$Companion;

    invoke-virtual {v1}, Lcom/rokid/aicore/api/AIEngine$Companion;->getInstance()Lcom/rokid/aicore/api/AIEngine;

    move-result-object v1

    const-string v2, "faceConfig"

    invoke-static {v0, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Lcom/rokid/aicore/api/AIEngine;->initFaceEngine(Lcom/rokid/aicore/ncnn/bean/MotConfig;)I

    .line 74
    sget-object v1, Lcom/rokid/aicore/api/AIEngine;->Companion:Lcom/rokid/aicore/api/AIEngine$Companion;

    invoke-virtual {v1}, Lcom/rokid/aicore/api/AIEngine$Companion;->getInstance()Lcom/rokid/aicore/api/AIEngine;

    move-result-object v1

    invoke-virtual {v1, p1}, Lcom/rokid/aicore/api/AIEngine;->addObserver(Lcom/rokid/aicore/api/callback/face/FaceCallback;)V

    .line 75
    sget-object v1, Lcom/rokid/security/phone/sdk/server/coreability/track/RecgEngine;->TAG:Ljava/lang/String;

    const-string v2, "initFaceSdk: end "

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 76
    return-void
.end method

.method public final initLprSdk(Lcom/rokid/aicore/api/callback/LPRCallback;)V
    .locals 3
    .param p1, "callback"    # Lcom/rokid/aicore/api/callback/LPRCallback;

    const-string v0, "callback"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 82
    new-instance v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    sget-object v1, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->kAlgorithmPlateRec:Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    const-string v2, "plate_det.ncnn"

    invoke-direct {v0, v1, v2}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;-><init>(Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;Ljava/lang/String;)V

    .line 83
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v1

    invoke-virtual {v1}, Landroid/app/Application;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->setAssetsMgr(Landroid/content/res/AssetManager;)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    move-result-object v0

    .line 84
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->setMaxNumDetections(I)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    move-result-object v0

    .line 85
    const-string v2, "plate_rec_color"

    invoke-virtual {v0, v2}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->setRecModelName(Ljava/lang/String;)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    move-result-object v0

    .line 86
    const v2, 0x3f4ccccd    # 0.8f

    invoke-virtual {v0, v2}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->setPlateCharThreshold(F)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    move-result-object v0

    .line 87
    const v2, 0x3e99999a    # 0.3f

    invoke-virtual {v0, v2}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->setPlateColorThreshold(F)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    move-result-object v0

    .line 88
    invoke-virtual {v0, v1}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->setSkipTrack(Z)Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;

    move-result-object v0

    .line 89
    invoke-virtual {v0}, Lcom/rokid/aicore/ncnn/bean/MotConfig$Builder;->build()Lcom/rokid/aicore/ncnn/bean/MotConfig;

    move-result-object v0

    .line 82
    nop

    .line 90
    .local v0, "lprConfig":Lcom/rokid/aicore/ncnn/bean/MotConfig;
    sget-object v1, Lcom/rokid/aicore/api/AIEngine;->Companion:Lcom/rokid/aicore/api/AIEngine$Companion;

    invoke-virtual {v1}, Lcom/rokid/aicore/api/AIEngine$Companion;->getInstance()Lcom/rokid/aicore/api/AIEngine;

    move-result-object v1

    const-string v2, "lprConfig"

    invoke-static {v0, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Lcom/rokid/aicore/api/AIEngine;->initLprEngine(Lcom/rokid/aicore/ncnn/bean/MotConfig;)I

    .line 91
    sget-object v1, Lcom/rokid/aicore/api/AIEngine;->Companion:Lcom/rokid/aicore/api/AIEngine$Companion;

    invoke-virtual {v1}, Lcom/rokid/aicore/api/AIEngine$Companion;->getInstance()Lcom/rokid/aicore/api/AIEngine;

    move-result-object v1

    invoke-virtual {v1, p1}, Lcom/rokid/aicore/api/AIEngine;->addObserver(Lcom/rokid/aicore/api/callback/LPRCallback;)V

    .line 92
    return-void
.end method

.method public final isEnabledRecogMode(I)Z
    .locals 1
    .param p1, "recogMode"    # I

    .line 38
    sget v0, Lcom/rokid/security/phone/sdk/server/coreability/track/RecgEngine;->recogMode:I

    if-ne v0, p1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public final processAsync(Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;)V
    .locals 5
    .param p1, "recgImageInput"    # Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;

    const-string v0, "recgImageInput"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 43
    new-instance v0, Lcom/rokid/aicore/api/bean/ImageInput;

    invoke-direct {v0}, Lcom/rokid/aicore/api/bean/ImageInput;-><init>()V

    move-object v1, v0

    .local v1, "$this$processAsync_u24lambda_u240":Lcom/rokid/aicore/api/bean/ImageInput;
    const/4 v2, 0x0

    .line 44
    .local v2, "$i$a$-apply-RecgEngine$processAsync$imageInput$1":I
    invoke-virtual {p1}, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->getWidth()I

    move-result v3

    iput v3, v1, Lcom/rokid/aicore/api/bean/ImageInput;->width:I

    .line 45
    invoke-virtual {p1}, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->getHeight()I

    move-result v3

    iput v3, v1, Lcom/rokid/aicore/api/bean/ImageInput;->height:I

    .line 46
    sget-object v3, Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;->kImageTypeNV21:Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    iput-object v3, v1, Lcom/rokid/aicore/api/bean/ImageInput;->type:Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    .line 47
    invoke-virtual {p1}, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->getData()[B

    move-result-object v3

    iput-object v3, v1, Lcom/rokid/aicore/api/bean/ImageInput;->data:[B

    .line 48
    invoke-virtual {p1}, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->getFrame_id()J

    move-result-wide v3

    iput-wide v3, v1, Lcom/rokid/aicore/api/bean/ImageInput;->frame_id:J

    .line 49
    nop

    .line 43
    .end local v1    # "$this$processAsync_u24lambda_u240":Lcom/rokid/aicore/api/bean/ImageInput;
    .end local v2    # "$i$a$-apply-RecgEngine$processAsync$imageInput$1":I
    nop

    .line 50
    .local v0, "imageInput":Lcom/rokid/aicore/api/bean/ImageInput;
    sget-object v1, Lcom/rokid/aicore/api/AIEngine;->Companion:Lcom/rokid/aicore/api/AIEngine$Companion;

    invoke-virtual {v1}, Lcom/rokid/aicore/api/AIEngine$Companion;->getInstance()Lcom/rokid/aicore/api/AIEngine;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/rokid/aicore/api/AIEngine;->processAsync(Lcom/rokid/aicore/api/bean/ImageInput;)Z

    .line 51
    return-void
.end method

.method public final setRecogMode(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 24
    sput p1, Lcom/rokid/security/phone/sdk/server/coreability/track/RecgEngine;->recogMode:I

    return-void
.end method

.method public final setTAG(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 22
    sput-object p1, Lcom/rokid/security/phone/sdk/server/coreability/track/RecgEngine;->TAG:Ljava/lang/String;

    return-void
.end method
