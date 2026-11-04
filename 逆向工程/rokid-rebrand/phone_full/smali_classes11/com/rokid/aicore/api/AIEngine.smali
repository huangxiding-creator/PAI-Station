.class public final Lcom/rokid/aicore/api/AIEngine;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/aicore/api/AIEngine$Companion;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u00b0\u0001\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\u0004\n\u0002\u0010\u0014\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010\t\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000b\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u000e\n\u0002\u0008\u000c\n\u0002\u0010\u0007\n\u0002\u0008\u0005\u0018\u0000 S2\u00020\u0001:\u0001SB\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0016\u0010\u0014\u001a\u00020\u00152\u0006\u0010\u0016\u001a\u00020\u00152\u0006\u0010\u0017\u001a\u00020\u0015J\u001e\u0010\u0018\u001a\u00020\u00152\u0006\u0010\u0016\u001a\u00020\u00152\u0006\u0010\u0017\u001a\u00020\u00152\u0006\u0010\u0019\u001a\u00020\u001aJ\u0010\u0010\u001b\u001a\u00020\u001c2\u0006\u0010\u001d\u001a\u00020\u000eH\u0016J\u0010\u0010\u001e\u001a\u00020\u001c2\u0006\u0010\u001d\u001a\u00020\u000eH\u0016J\u0010\u0010\u001e\u001a\u00020\u001c2\u0006\u0010\u001f\u001a\u00020\u0007H\u0016J\u0016\u0010 \u001a\u00020\u00152\u0006\u0010\u0016\u001a\u00020\u00152\u0006\u0010\u0017\u001a\u00020\u0015J\u0018\u0010!\u001a\u0004\u0018\u00010\"2\u0006\u0010#\u001a\u00020$2\u0006\u0010\u0016\u001a\u00020%J\u0008\u0010&\u001a\u00020\u001cH\u0016J\u0016\u0010\'\u001a\u00020\u001c2\u0006\u0010(\u001a\u00020)2\u0006\u0010*\u001a\u00020+J\u0008\u0010,\u001a\u00020\u001cH\u0002J\u0008\u0010-\u001a\u00020\u001cH\u0002J\u000e\u0010.\u001a\u00020\u00152\u0006\u0010/\u001a\u000200J\u000e\u00101\u001a\u00020\u00152\u0006\u0010/\u001a\u000200J\u000e\u00102\u001a\u00020\u00152\u0006\u0010/\u001a\u000200J\u000e\u00103\u001a\u00020\u00152\u0006\u0010/\u001a\u000200J\u000e\u0010*\u001a\u00020+2\u0006\u0010(\u001a\u00020)J\u0018\u00104\u001a\u0004\u0018\u0001052\u0006\u0010\u0016\u001a\u00020\u00152\u0006\u0010\u0017\u001a\u00020\u0015J\u000e\u00106\u001a\u00020+2\u0006\u00107\u001a\u000208J\u000e\u00109\u001a\u00020+2\u0006\u00107\u001a\u000208J\u000e\u0010:\u001a\u00020+2\u0006\u00107\u001a\u00020;J\u0010\u0010<\u001a\u0004\u0018\u00010=2\u0006\u00107\u001a\u00020>J\u0008\u0010?\u001a\u00020\u001cH\u0016J\u000e\u0010@\u001a\u00020\u001c2\u0006\u0010A\u001a\u00020BJ\u000e\u0010C\u001a\u00020\u001c2\u0006\u0010A\u001a\u00020BJ\u0006\u0010D\u001a\u00020\u001cJ\u0010\u0010E\u001a\u00020\u001c2\u0006\u0010\u001d\u001a\u00020\u000eH\u0016J\u0010\u0010F\u001a\u00020\u001c2\u0006\u0010\u001d\u001a\u00020\u000eH\u0016J\u0010\u0010F\u001a\u00020\u001c2\u0006\u0010\u001f\u001a\u00020\u0007H\u0016J\u0016\u0010G\u001a\u00020\u001c2\u0006\u0010A\u001a\u00020B2\u0006\u0010H\u001a\u00020BJ\u0016\u0010I\u001a\u00020\u001c2\u0006\u0010A\u001a\u00020B2\u0006\u0010H\u001a\u00020BJ\u0016\u0010J\u001a\u00020\u001c2\u0006\u0010K\u001a\u00020\u00152\u0006\u0010L\u001a\u00020\u0015J\u000e\u0010M\u001a\u00020\u001c2\u0006\u0010N\u001a\u00020OJ\u000e\u0010P\u001a\u00020\u001c2\u0006\u0010Q\u001a\u00020\u0010J\u0016\u0010R\u001a\u00020\u001c2\u0006\u0010K\u001a\u00020\u00152\u0006\u0010L\u001a\u00020\u0015R\u0010\u0010\u0003\u001a\u0004\u0018\u00010\u0004X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u001e\u0010\u0005\u001a\u0012\u0012\u0004\u0012\u00020\u00070\u0006j\u0008\u0012\u0004\u0012\u00020\u0007`\u0008X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\t\u001a\u0004\u0018\u00010\nX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u000b\u001a\u0004\u0018\u00010\u000cX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u001e\u0010\r\u001a\u0012\u0012\u0004\u0012\u00020\u000e0\u0006j\u0008\u0012\u0004\u0012\u00020\u000e`\u0008X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u000f\u001a\u0004\u0018\u00010\u0010X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0011\u001a\u0004\u0018\u00010\u0012X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u001e\u0010\u0013\u001a\u0012\u0012\u0004\u0012\u00020\u000e0\u0006j\u0008\u0012\u0004\u0012\u00020\u000e`\u0008X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006T"
    }
    d2 = {
        "Lcom/rokid/aicore/api/AIEngine;",
        "",
        "()V",
        "mFaceEngine",
        "Lcom/rokid/aicore/api/engines/FaceEngine;",
        "mFaceObservers",
        "Ljava/util/ArrayList;",
        "Lcom/rokid/aicore/api/callback/face/FaceCallback;",
        "Lkotlin/collections/ArrayList;",
        "mFaceRecogEngine",
        "Lcom/rokid/aicore/api/engines/FaceRecogEngine;",
        "mLprEngine",
        "Lcom/rokid/aicore/api/engines/LPREngine;",
        "mLprObservers",
        "Lcom/rokid/aicore/api/callback/LPRCallback;",
        "mMotorLPRProcessCallback",
        "Lcom/rokid/aicore/api/callback/result/MotorLPRProcessCallback;",
        "mMotorLprEngine",
        "Lcom/rokid/aicore/api/engines/MotorLPREngine;",
        "mMotorLprObservers",
        "addActiveFace",
        "",
        "frameId",
        "trackId",
        "addActiveFaceFeature",
        "faceFeature",
        "",
        "addMotorObserver",
        "",
        "lprCallback",
        "addObserver",
        "faceCallback",
        "clearActiveFace",
        "cropFace",
        "Landroid/graphics/Bitmap;",
        "rect",
        "Landroid/graphics/Rect;",
        "",
        "destroy",
        "enable",
        "detectType",
        "Lcom/rokid/aicore/api/bean/DetectType;",
        "isEnable",
        "",
        "initAllEngines",
        "initEngine",
        "initFaceEngine",
        "config",
        "Lcom/rokid/aicore/ncnn/bean/MotConfig;",
        "initFaceRecogEngine",
        "initLprEngine",
        "initMotorLprEngine",
        "matchActiveFace",
        "Lcom/rokid/aicore/ncnn/MotWrapper$MatchResult;",
        "process",
        "imageInput",
        "Lcom/rokid/aicore/api/bean/ImageInput;",
        "processAsync",
        "processBuffer",
        "Lcom/rokid/aicore/api/bean/BufferImageInput;",
        "processFaceRecognize",
        "Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;",
        "Lcom/rokid/aicore/api/bean/RecognizeDataInput;",
        "removeAllObservers",
        "removeFaceFeature",
        "featureName",
        "",
        "removeFaceRecogFeature",
        "removeMotorLPRProcessCallback",
        "removeMotorObserver",
        "removeObserver",
        "setFaceFeatureFile",
        "featurePath",
        "setFaceRecogFeatureFile",
        "setLPRRectThreshold",
        "width",
        "area",
        "setLprCharGoodEnoughThreshold",
        "goodEnoughScore",
        "",
        "setMotorLPRProcessCallback",
        "callback",
        "setMotorLPRRectThreshold",
        "Companion",
        "aicore_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x5,
        0x1
    }
    xi = 0x30
.end annotation


# static fields
.field public static final Companion:Lcom/rokid/aicore/api/AIEngine$Companion;

.field private static final TAG:Ljava/lang/String; = "####AIEngine"

.field private static volatile instance:Lcom/rokid/aicore/api/AIEngine;


# instance fields
.field private mFaceEngine:Lcom/rokid/aicore/api/engines/FaceEngine;

.field private mFaceObservers:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/rokid/aicore/api/callback/face/FaceCallback;",
            ">;"
        }
    .end annotation
.end field

.field private mFaceRecogEngine:Lcom/rokid/aicore/api/engines/FaceRecogEngine;

.field private mLprEngine:Lcom/rokid/aicore/api/engines/LPREngine;

.field private mLprObservers:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/rokid/aicore/api/callback/LPRCallback;",
            ">;"
        }
    .end annotation
.end field

.field private mMotorLPRProcessCallback:Lcom/rokid/aicore/api/callback/result/MotorLPRProcessCallback;

.field private mMotorLprEngine:Lcom/rokid/aicore/api/engines/MotorLPREngine;

.field private mMotorLprObservers:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/rokid/aicore/api/callback/LPRCallback;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public static synthetic $r8$lambda$U6a30ZOlfcwAi-e8SbPtXv5FJ58(Lcom/rokid/aicore/api/AIEngine;Ljava/util/ArrayList;J)V
    .locals 0

    invoke-static {p0, p1, p2, p3}, Lcom/rokid/aicore/api/AIEngine;->initAllEngines$lambda-3(Lcom/rokid/aicore/api/AIEngine;Ljava/util/ArrayList;J)V

    return-void
.end method

.method public static synthetic $r8$lambda$a90K19cg-YmOUdD0BGPaOpHQsWI(Lcom/rokid/aicore/api/AIEngine;Ljava/util/ArrayList;J)V
    .locals 0

    invoke-static {p0, p1, p2, p3}, Lcom/rokid/aicore/api/AIEngine;->initAllEngines$lambda-1(Lcom/rokid/aicore/api/AIEngine;Ljava/util/ArrayList;J)V

    return-void
.end method

.method public static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/aicore/api/AIEngine$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/aicore/api/AIEngine$Companion;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lcom/rokid/aicore/api/AIEngine;->Companion:Lcom/rokid/aicore/api/AIEngine$Companion;

    return-void
.end method

.method private constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-direct {p0}, Lcom/rokid/aicore/api/AIEngine;->initEngine()V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mMotorLprObservers:Ljava/util/ArrayList;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mLprObservers:Ljava/util/ArrayList;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mFaceObservers:Ljava/util/ArrayList;

    return-void
.end method

.method public synthetic constructor <init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V
    .locals 0

    invoke-direct {p0}, Lcom/rokid/aicore/api/AIEngine;-><init>()V

    return-void
.end method

.method public static final synthetic access$getInstance$cp()Lcom/rokid/aicore/api/AIEngine;
    .locals 1

    sget-object v0, Lcom/rokid/aicore/api/AIEngine;->instance:Lcom/rokid/aicore/api/AIEngine;

    return-object v0
.end method

.method public static final synthetic access$getMFaceObservers$p(Lcom/rokid/aicore/api/AIEngine;)Ljava/util/ArrayList;
    .locals 0

    iget-object p0, p0, Lcom/rokid/aicore/api/AIEngine;->mFaceObservers:Ljava/util/ArrayList;

    return-object p0
.end method

.method public static final synthetic access$setInstance$cp(Lcom/rokid/aicore/api/AIEngine;)V
    .locals 0

    sput-object p0, Lcom/rokid/aicore/api/AIEngine;->instance:Lcom/rokid/aicore/api/AIEngine;

    return-void
.end method

.method public static final getQnnRuntimeState()I
    .locals 1
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    sget-object v0, Lcom/rokid/aicore/api/AIEngine;->Companion:Lcom/rokid/aicore/api/AIEngine$Companion;

    invoke-virtual {v0}, Lcom/rokid/aicore/api/AIEngine$Companion;->getQnnRuntimeState()I

    move-result v0

    return v0
.end method

.method private final initAllEngines()V
    .locals 3

    sget-object v0, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    const-string v1, "####AIEngine"

    const-string v2, "#########  initEngine "

    invoke-virtual {v0, v1, v2}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v1, p0, Lcom/rokid/aicore/api/AIEngine;->mLprEngine:Lcom/rokid/aicore/api/engines/LPREngine;

    if-nez v1, :cond_0

    new-instance v1, Lcom/rokid/aicore/api/engines/LPREngine;

    invoke-direct {v1}, Lcom/rokid/aicore/api/engines/LPREngine;-><init>()V

    iput-object v1, p0, Lcom/rokid/aicore/api/AIEngine;->mLprEngine:Lcom/rokid/aicore/api/engines/LPREngine;

    :cond_0
    iget-object v1, p0, Lcom/rokid/aicore/api/AIEngine;->mLprEngine:Lcom/rokid/aicore/api/engines/LPREngine;

    if-nez v1, :cond_1

    goto :goto_0

    :cond_1
    new-instance v2, Lcom/rokid/aicore/api/AIEngine$$ExternalSyntheticLambda0;

    invoke-direct {v2, p0}, Lcom/rokid/aicore/api/AIEngine$$ExternalSyntheticLambda0;-><init>(Lcom/rokid/aicore/api/AIEngine;)V

    invoke-virtual {v1, v2}, Lcom/rokid/aicore/api/engines/LPREngine;->setLPRCallback(Lcom/rokid/aicore/api/callback/LPRCallback;)V

    :goto_0
    iget-object v1, p0, Lcom/rokid/aicore/api/AIEngine;->mMotorLprEngine:Lcom/rokid/aicore/api/engines/MotorLPREngine;

    if-nez v1, :cond_2

    new-instance v1, Lcom/rokid/aicore/api/engines/MotorLPREngine;

    invoke-direct {v1}, Lcom/rokid/aicore/api/engines/MotorLPREngine;-><init>()V

    iput-object v1, p0, Lcom/rokid/aicore/api/AIEngine;->mMotorLprEngine:Lcom/rokid/aicore/api/engines/MotorLPREngine;

    :cond_2
    iget-object v1, p0, Lcom/rokid/aicore/api/AIEngine;->mMotorLprEngine:Lcom/rokid/aicore/api/engines/MotorLPREngine;

    if-nez v1, :cond_3

    goto :goto_1

    :cond_3
    new-instance v2, Lcom/rokid/aicore/api/AIEngine$$ExternalSyntheticLambda1;

    invoke-direct {v2, p0}, Lcom/rokid/aicore/api/AIEngine$$ExternalSyntheticLambda1;-><init>(Lcom/rokid/aicore/api/AIEngine;)V

    invoke-virtual {v1, v2}, Lcom/rokid/aicore/api/engines/MotorLPREngine;->setLPRCallback(Lcom/rokid/aicore/api/callback/LPRCallback;)V

    :goto_1
    iget-object v1, p0, Lcom/rokid/aicore/api/AIEngine;->mFaceEngine:Lcom/rokid/aicore/api/engines/FaceEngine;

    if-nez v1, :cond_4

    new-instance v1, Lcom/rokid/aicore/api/engines/FaceEngine;

    invoke-direct {v1}, Lcom/rokid/aicore/api/engines/FaceEngine;-><init>()V

    iput-object v1, p0, Lcom/rokid/aicore/api/AIEngine;->mFaceEngine:Lcom/rokid/aicore/api/engines/FaceEngine;

    :cond_4
    iget-object v1, p0, Lcom/rokid/aicore/api/AIEngine;->mFaceEngine:Lcom/rokid/aicore/api/engines/FaceEngine;

    if-nez v1, :cond_5

    goto :goto_2

    :cond_5
    new-instance v2, Lcom/rokid/aicore/api/AIEngine$initAllEngines$3;

    invoke-direct {v2, p0}, Lcom/rokid/aicore/api/AIEngine$initAllEngines$3;-><init>(Lcom/rokid/aicore/api/AIEngine;)V

    invoke-virtual {v1, v2}, Lcom/rokid/aicore/api/engines/FaceEngine;->setFaceTrackCallback(Lcom/rokid/aicore/api/callback/face/FaceCallback;)V

    :goto_2
    iget-object v1, p0, Lcom/rokid/aicore/api/AIEngine;->mFaceRecogEngine:Lcom/rokid/aicore/api/engines/FaceRecogEngine;

    if-nez v1, :cond_6

    new-instance v1, Lcom/rokid/aicore/api/engines/FaceRecogEngine;

    invoke-direct {v1}, Lcom/rokid/aicore/api/engines/FaceRecogEngine;-><init>()V

    iput-object v1, p0, Lcom/rokid/aicore/api/AIEngine;->mFaceRecogEngine:Lcom/rokid/aicore/api/engines/FaceRecogEngine;

    :cond_6
    const-string v1, "######### initEngine end"

    invoke-virtual {v0, v1}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    return-void
.end method

.method private static final initAllEngines$lambda-1(Lcom/rokid/aicore/api/AIEngine;Ljava/util/ArrayList;J)V
    .locals 2

    const-string v0, "this$0"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    sget-object v0, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    const-string v1, "###########onLPREvent lprResultArrayList:"

    invoke-static {v1, p1}, Lkotlin/jvm/internal/Intrinsics;->stringPlus(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    iget-object p0, p0, Lcom/rokid/aicore/api/AIEngine;->mLprObservers:Ljava/util/ArrayList;

    invoke-interface {p0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :goto_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/aicore/api/callback/LPRCallback;

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    invoke-interface {v0, p1, p2, p3}, Lcom/rokid/aicore/api/callback/LPRCallback;->onLPREvent(Ljava/util/ArrayList;J)V

    goto :goto_0

    :cond_1
    return-void
.end method

.method private static final initAllEngines$lambda-3(Lcom/rokid/aicore/api/AIEngine;Ljava/util/ArrayList;J)V
    .locals 2

    const-string v0, "this$0"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    sget-object v0, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    const-string v1, "###########MotorLPR#onLPREvent lprResultArrayList:"

    invoke-static {v1, p1}, Lkotlin/jvm/internal/Intrinsics;->stringPlus(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    iget-object p0, p0, Lcom/rokid/aicore/api/AIEngine;->mMotorLprObservers:Ljava/util/ArrayList;

    invoke-interface {p0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :goto_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/aicore/api/callback/LPRCallback;

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    invoke-interface {v0, p1, p2, p3}, Lcom/rokid/aicore/api/callback/LPRCallback;->onLPREvent(Ljava/util/ArrayList;J)V

    goto :goto_0

    :cond_1
    return-void
.end method

.method private final initEngine()V
    .locals 2

    sget-object v0, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    const-string v1, "#########  start initEngine "

    invoke-virtual {v0, v1}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    invoke-direct {p0}, Lcom/rokid/aicore/api/AIEngine;->initAllEngines()V

    return-void
.end method

.method public static final prepareQnnRuntime()I
    .locals 1
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    sget-object v0, Lcom/rokid/aicore/api/AIEngine;->Companion:Lcom/rokid/aicore/api/AIEngine$Companion;

    invoke-virtual {v0}, Lcom/rokid/aicore/api/AIEngine$Companion;->prepareQnnRuntime()I

    move-result v0

    return v0
.end method


# virtual methods
.method public final addActiveFace(II)I
    .locals 5

    sget-object v0, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "######### addActiveFace frameId: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "; trackId: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/rokid/aicore/api/AIEngine;->mFaceEngine:Lcom/rokid/aicore/api/engines/FaceEngine;

    if-nez v1, :cond_0

    const/4 v1, -0x1

    goto :goto_0

    :cond_0
    invoke-virtual {v1, p1, p2}, Lcom/rokid/aicore/api/engines/BaseEngine;->addActiveFace(II)I

    move-result v1

    :goto_0
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, " result: "

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    return v1
.end method

.method public final addActiveFaceFeature(II[F)I
    .locals 3

    const-string v0, "faceFeature"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    sget-object v0, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "######### addActiveFaceFeature frameId: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "; trackId: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mFaceEngine:Lcom/rokid/aicore/api/engines/FaceEngine;

    if-nez v0, :cond_0

    const/4 p1, -0x1

    goto :goto_0

    :cond_0
    invoke-virtual {v0, p1, p2, p3}, Lcom/rokid/aicore/api/engines/BaseEngine;->addActiveFeature(II[F)I

    move-result p1

    :goto_0
    return p1
.end method

.method public addMotorObserver(Lcom/rokid/aicore/api/callback/LPRCallback;)V
    .locals 1

    const-string v0, "lprCallback"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mMotorLprObservers:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mMotorLprObservers:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public addObserver(Lcom/rokid/aicore/api/callback/LPRCallback;)V
    .locals 1

    const-string v0, "lprCallback"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mLprObservers:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mLprObservers:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public addObserver(Lcom/rokid/aicore/api/callback/face/FaceCallback;)V
    .locals 1

    const-string v0, "faceCallback"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mFaceObservers:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mFaceObservers:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public final clearActiveFace(II)I
    .locals 3

    sget-object v0, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "######### clearActiveFace, frameId: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "; trackId: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mFaceEngine:Lcom/rokid/aicore/api/engines/FaceEngine;

    if-nez v0, :cond_0

    const/4 p1, -0x1

    goto :goto_0

    :cond_0
    invoke-virtual {v0, p1, p2}, Lcom/rokid/aicore/api/engines/BaseEngine;->clearActiveFace(II)I

    move-result p1

    :goto_0
    return p1
.end method

.method public final cropFace(Landroid/graphics/Rect;J)Landroid/graphics/Bitmap;
    .locals 1

    const-string v0, "rect"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mFaceEngine:Lcom/rokid/aicore/api/engines/FaceEngine;

    if-nez v0, :cond_0

    const/4 p1, 0x0

    goto :goto_0

    :cond_0
    invoke-virtual {v0, p1, p2, p3}, Lcom/rokid/aicore/api/engines/BaseEngine;->cropSmallFaceBitmap(Landroid/graphics/Rect;J)Landroid/graphics/Bitmap;

    move-result-object p1

    :goto_0
    return-object p1
.end method

.method public destroy()V
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mLprEngine:Lcom/rokid/aicore/api/engines/LPREngine;

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {v0}, Lcom/rokid/aicore/api/engines/BaseEngine;->disable()V

    :goto_0
    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mLprEngine:Lcom/rokid/aicore/api/engines/LPREngine;

    if-nez v0, :cond_1

    goto :goto_1

    :cond_1
    invoke-virtual {v0}, Lcom/rokid/aicore/api/engines/LPREngine;->release()V

    :goto_1
    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mLprObservers:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mFaceEngine:Lcom/rokid/aicore/api/engines/FaceEngine;

    if-nez v0, :cond_2

    goto :goto_2

    :cond_2
    invoke-virtual {v0}, Lcom/rokid/aicore/api/engines/BaseEngine;->disable()V

    :goto_2
    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mFaceEngine:Lcom/rokid/aicore/api/engines/FaceEngine;

    if-nez v0, :cond_3

    goto :goto_3

    :cond_3
    invoke-virtual {v0}, Lcom/rokid/aicore/api/engines/FaceEngine;->release()V

    :goto_3
    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mFaceObservers:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mMotorLprEngine:Lcom/rokid/aicore/api/engines/MotorLPREngine;

    if-nez v0, :cond_4

    goto :goto_4

    :cond_4
    invoke-virtual {v0}, Lcom/rokid/aicore/api/engines/BaseEngine;->disable()V

    :goto_4
    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mMotorLprEngine:Lcom/rokid/aicore/api/engines/MotorLPREngine;

    if-nez v0, :cond_5

    goto :goto_5

    :cond_5
    invoke-virtual {v0}, Lcom/rokid/aicore/api/engines/MotorLPREngine;->release()V

    :goto_5
    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mMotorLprObservers:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mFaceRecogEngine:Lcom/rokid/aicore/api/engines/FaceRecogEngine;

    if-nez v0, :cond_6

    goto :goto_6

    :cond_6
    invoke-virtual {v0}, Lcom/rokid/aicore/api/engines/FaceRecogEngine;->release()V

    :goto_6
    const/4 v0, 0x0

    sput-object v0, Lcom/rokid/aicore/api/AIEngine;->instance:Lcom/rokid/aicore/api/AIEngine;

    return-void
.end method

.method public final enable(Lcom/rokid/aicore/api/bean/DetectType;Z)V
    .locals 1

    const-string v0, "detectType"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    sget-object v0, Lcom/rokid/aicore/api/bean/DetectType;->LPR:Lcom/rokid/aicore/api/bean/DetectType;

    if-ne p1, v0, :cond_1

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mLprEngine:Lcom/rokid/aicore/api/engines/LPREngine;

    if-eqz v0, :cond_1

    if-eqz p2, :cond_0

    goto :goto_0

    :cond_0
    if-nez v0, :cond_3

    goto :goto_1

    :cond_1
    sget-object v0, Lcom/rokid/aicore/api/bean/DetectType;->FACE:Lcom/rokid/aicore/api/bean/DetectType;

    if-ne p1, v0, :cond_4

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mFaceEngine:Lcom/rokid/aicore/api/engines/FaceEngine;

    if-eqz v0, :cond_4

    if-eqz p2, :cond_2

    :goto_0
    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v0}, Lcom/rokid/aicore/api/engines/BaseEngine;->enable()V

    goto :goto_1

    :cond_2
    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    :cond_3
    invoke-virtual {v0}, Lcom/rokid/aicore/api/engines/BaseEngine;->disable()V

    goto :goto_1

    :cond_4
    sget-object v0, Lcom/rokid/aicore/api/bean/DetectType;->MOTOR:Lcom/rokid/aicore/api/bean/DetectType;

    if-ne p1, v0, :cond_8

    iget-object p1, p0, Lcom/rokid/aicore/api/AIEngine;->mMotorLprEngine:Lcom/rokid/aicore/api/engines/MotorLPREngine;

    if-eqz p1, :cond_8

    if-eqz p2, :cond_6

    if-nez p1, :cond_5

    goto :goto_1

    :cond_5
    invoke-virtual {p1}, Lcom/rokid/aicore/api/engines/BaseEngine;->enable()V

    goto :goto_1

    :cond_6
    if-nez p1, :cond_7

    goto :goto_1

    :cond_7
    invoke-virtual {p1}, Lcom/rokid/aicore/api/engines/BaseEngine;->disable()V

    :cond_8
    :goto_1
    return-void
.end method

.method public final initFaceEngine(Lcom/rokid/aicore/ncnn/bean/MotConfig;)I
    .locals 1

    const-string v0, "config"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mFaceEngine:Lcom/rokid/aicore/api/engines/FaceEngine;

    if-nez v0, :cond_0

    const/4 p1, -0x1

    return p1

    :cond_0
    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v0, p1}, Lcom/rokid/aicore/api/engines/FaceEngine;->initConfig(Lcom/rokid/aicore/ncnn/bean/MotConfig;)I

    move-result p1

    return p1
.end method

.method public final initFaceRecogEngine(Lcom/rokid/aicore/ncnn/bean/MotConfig;)I
    .locals 1

    const-string v0, "config"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mFaceRecogEngine:Lcom/rokid/aicore/api/engines/FaceRecogEngine;

    if-nez v0, :cond_0

    const/4 p1, -0x1

    return p1

    :cond_0
    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v0, p1}, Lcom/rokid/aicore/api/engines/FaceRecogEngine;->initConfig(Lcom/rokid/aicore/ncnn/bean/MotConfig;)I

    move-result p1

    return p1
.end method

.method public final initLprEngine(Lcom/rokid/aicore/ncnn/bean/MotConfig;)I
    .locals 1

    const-string v0, "config"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mLprEngine:Lcom/rokid/aicore/api/engines/LPREngine;

    if-nez v0, :cond_0

    const/4 p1, -0x1

    return p1

    :cond_0
    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v0, p1}, Lcom/rokid/aicore/api/engines/LPREngine;->initConfig(Lcom/rokid/aicore/ncnn/bean/MotConfig;)I

    move-result p1

    return p1
.end method

.method public final initMotorLprEngine(Lcom/rokid/aicore/ncnn/bean/MotConfig;)I
    .locals 1

    const-string v0, "config"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mMotorLprEngine:Lcom/rokid/aicore/api/engines/MotorLPREngine;

    if-nez v0, :cond_0

    const/4 p1, -0x1

    return p1

    :cond_0
    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v0, p1}, Lcom/rokid/aicore/api/engines/MotorLPREngine;->initConfig(Lcom/rokid/aicore/ncnn/bean/MotConfig;)I

    move-result p1

    return p1
.end method

.method public final isEnable(Lcom/rokid/aicore/api/bean/DetectType;)Z
    .locals 2

    const-string v0, "detectType"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    sget-object v0, Lcom/rokid/aicore/api/bean/DetectType;->LPR:Lcom/rokid/aicore/api/bean/DetectType;

    const/4 v1, 0x0

    if-ne p1, v0, :cond_1

    iget-object p1, p0, Lcom/rokid/aicore/api/AIEngine;->mLprEngine:Lcom/rokid/aicore/api/engines/LPREngine;

    if-nez p1, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Lcom/rokid/aicore/api/engines/BaseEngine;->isEnable()Z

    move-result p1

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    :goto_0
    sget-object p1, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-static {v1, p1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result p1

    goto :goto_1

    :cond_1
    sget-object v0, Lcom/rokid/aicore/api/bean/DetectType;->FACE:Lcom/rokid/aicore/api/bean/DetectType;

    if-ne p1, v0, :cond_2

    iget-object p1, p0, Lcom/rokid/aicore/api/AIEngine;->mFaceEngine:Lcom/rokid/aicore/api/engines/FaceEngine;

    if-nez p1, :cond_0

    goto :goto_0

    :cond_2
    sget-object v0, Lcom/rokid/aicore/api/bean/DetectType;->MOTOR:Lcom/rokid/aicore/api/bean/DetectType;

    if-ne p1, v0, :cond_3

    iget-object p1, p0, Lcom/rokid/aicore/api/AIEngine;->mMotorLprEngine:Lcom/rokid/aicore/api/engines/MotorLPREngine;

    if-nez p1, :cond_0

    goto :goto_0

    :cond_3
    const/4 p1, 0x0

    :goto_1
    return p1
.end method

.method public final matchActiveFace(II)Lcom/rokid/aicore/ncnn/MotWrapper$MatchResult;
    .locals 7

    sget-object v0, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "######### matchActiveFace, frameId: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "; trackId: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    new-instance v1, Lcom/rokid/aicore/ncnn/MotWrapper$MatchResult;

    invoke-direct {v1}, Lcom/rokid/aicore/ncnn/MotWrapper$MatchResult;-><init>()V

    iget-object v3, p0, Lcom/rokid/aicore/api/AIEngine;->mFaceEngine:Lcom/rokid/aicore/api/engines/FaceEngine;

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move-object v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {v3, p1, p2, v1}, Lcom/rokid/aicore/api/engines/BaseEngine;->matchActiveFace(IILcom/rokid/aicore/ncnn/MotWrapper$MatchResult;)Z

    move-result v3

    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    :goto_0
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "######### matchActiveFace frameId: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, " result: "

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, ", matchResult: "

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/rokid/aicore/utils/LogUtil$Companion;->i(Ljava/lang/String;)V

    sget-object p1, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-static {v3, p1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_1

    goto :goto_1

    :cond_1
    move-object v1, v4

    :goto_1
    return-object v1
.end method

.method public final process(Lcom/rokid/aicore/api/bean/ImageInput;)Z
    .locals 4

    const-string v0, "imageInput"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v0, p1, Lcom/rokid/aicore/api/bean/ImageInput;->data:[B

    const/4 v1, 0x0

    const-string v2, "####AIEngine"

    if-nez v0, :cond_0

    sget-object p1, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    const-string v0, "process error.imageInput is null"

    :goto_0
    invoke-virtual {p1, v2, v0}, Lcom/rokid/aicore/utils/LogUtil$Companion;->d(Ljava/lang/String;Ljava/lang/String;)V

    return v1

    :cond_0
    const-string v3, "imageInput.data"

    invoke-static {v0, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    array-length v0, v0

    if-nez v0, :cond_1

    sget-object p1, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    const-string v0, "process error.ImageInput data size is 0 "

    goto :goto_0

    :cond_1
    iget-object v0, p1, Lcom/rokid/aicore/api/bean/ImageInput;->type:Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    invoke-virtual {v0}, Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;->ordinal()I

    move-result v0

    if-gez v0, :cond_2

    sget-object p1, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    const-string v0, "process error.ImageInput type is error "

    goto :goto_0

    :cond_2
    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mFaceEngine:Lcom/rokid/aicore/api/engines/FaceEngine;

    const/4 v1, 0x0

    if-nez v0, :cond_3

    move-object v0, v1

    goto :goto_1

    :cond_3
    invoke-virtual {v0}, Lcom/rokid/aicore/api/engines/BaseEngine;->isEnable()Z

    move-result v0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    :goto_1
    sget-object v2, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-static {v0, v2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mFaceEngine:Lcom/rokid/aicore/api/engines/FaceEngine;

    if-nez v0, :cond_4

    goto :goto_2

    :cond_4
    invoke-virtual {v0, p1}, Lcom/rokid/aicore/api/engines/BaseEngine;->process(Lcom/rokid/aicore/api/bean/ImageInput;)Z

    :cond_5
    :goto_2
    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mLprEngine:Lcom/rokid/aicore/api/engines/LPREngine;

    if-nez v0, :cond_6

    move-object v0, v1

    goto :goto_3

    :cond_6
    invoke-virtual {v0}, Lcom/rokid/aicore/api/engines/BaseEngine;->isEnable()Z

    move-result v0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    :goto_3
    invoke-static {v0, v2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_8

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mLprEngine:Lcom/rokid/aicore/api/engines/LPREngine;

    if-nez v0, :cond_7

    goto :goto_4

    :cond_7
    invoke-virtual {v0, p1}, Lcom/rokid/aicore/api/engines/BaseEngine;->process(Lcom/rokid/aicore/api/bean/ImageInput;)Z

    :cond_8
    :goto_4
    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mMotorLprEngine:Lcom/rokid/aicore/api/engines/MotorLPREngine;

    if-nez v0, :cond_9

    goto :goto_5

    :cond_9
    invoke-virtual {v0}, Lcom/rokid/aicore/api/engines/BaseEngine;->isEnable()Z

    move-result v0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    :goto_5
    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_b

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mMotorLprEngine:Lcom/rokid/aicore/api/engines/MotorLPREngine;

    if-nez v0, :cond_a

    goto :goto_6

    :cond_a
    invoke-virtual {v0, p1}, Lcom/rokid/aicore/api/engines/BaseEngine;->process(Lcom/rokid/aicore/api/bean/ImageInput;)Z

    :cond_b
    :goto_6
    const/4 p1, 0x1

    return p1
.end method

.method public final processAsync(Lcom/rokid/aicore/api/bean/ImageInput;)Z
    .locals 4

    const-string v0, "imageInput"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v0, p1, Lcom/rokid/aicore/api/bean/ImageInput;->data:[B

    const/4 v1, 0x0

    const-string v2, "####AIEngine"

    if-nez v0, :cond_0

    sget-object p1, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    const-string v0, "processAsync error.imageInput is null"

    :goto_0
    invoke-virtual {p1, v2, v0}, Lcom/rokid/aicore/utils/LogUtil$Companion;->d(Ljava/lang/String;Ljava/lang/String;)V

    return v1

    :cond_0
    const-string v3, "imageInput.data"

    invoke-static {v0, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    array-length v0, v0

    if-nez v0, :cond_1

    sget-object p1, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    const-string v0, "processAsync error.ImageInput data size is 0 "

    goto :goto_0

    :cond_1
    iget-object v0, p1, Lcom/rokid/aicore/api/bean/ImageInput;->type:Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    invoke-virtual {v0}, Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;->ordinal()I

    move-result v0

    if-gez v0, :cond_2

    sget-object p1, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    const-string v0, "processAsync error.ImageInput type is error "

    goto :goto_0

    :cond_2
    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mFaceEngine:Lcom/rokid/aicore/api/engines/FaceEngine;

    const/4 v1, 0x0

    if-nez v0, :cond_3

    move-object v0, v1

    goto :goto_1

    :cond_3
    invoke-virtual {v0}, Lcom/rokid/aicore/api/engines/BaseEngine;->isEnable()Z

    move-result v0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    :goto_1
    sget-object v2, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-static {v0, v2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mFaceEngine:Lcom/rokid/aicore/api/engines/FaceEngine;

    if-nez v0, :cond_4

    goto :goto_2

    :cond_4
    invoke-virtual {v0, p1}, Lcom/rokid/aicore/api/engines/BaseEngine;->processAsyncV2(Lcom/rokid/aicore/api/bean/ImageInput;)Z

    :cond_5
    :goto_2
    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mLprEngine:Lcom/rokid/aicore/api/engines/LPREngine;

    if-nez v0, :cond_6

    move-object v0, v1

    goto :goto_3

    :cond_6
    invoke-virtual {v0}, Lcom/rokid/aicore/api/engines/BaseEngine;->isEnable()Z

    move-result v0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    :goto_3
    invoke-static {v0, v2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_8

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mLprEngine:Lcom/rokid/aicore/api/engines/LPREngine;

    if-nez v0, :cond_7

    goto :goto_4

    :cond_7
    invoke-virtual {v0, p1}, Lcom/rokid/aicore/api/engines/BaseEngine;->processAsync(Lcom/rokid/aicore/api/bean/ImageInput;)Z

    :cond_8
    :goto_4
    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mMotorLprEngine:Lcom/rokid/aicore/api/engines/MotorLPREngine;

    if-nez v0, :cond_9

    goto :goto_5

    :cond_9
    invoke-virtual {v0}, Lcom/rokid/aicore/api/engines/BaseEngine;->isEnable()Z

    move-result v0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    :goto_5
    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_b

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mMotorLprEngine:Lcom/rokid/aicore/api/engines/MotorLPREngine;

    if-nez v0, :cond_a

    goto :goto_6

    :cond_a
    invoke-virtual {v0, p1}, Lcom/rokid/aicore/api/engines/BaseEngine;->processAsync(Lcom/rokid/aicore/api/bean/ImageInput;)Z

    :cond_b
    :goto_6
    const/4 p1, 0x1

    return p1
.end method

.method public final processBuffer(Lcom/rokid/aicore/api/bean/BufferImageInput;)Z
    .locals 3

    const-string v0, "imageInput"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {p1}, Lcom/rokid/aicore/api/bean/BufferImageInput;->isValid()Z

    move-result v0

    if-nez v0, :cond_0

    sget-object p1, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    const-string v0, "####AIEngine"

    const-string v1, "processBuffer error.invalid direct buffer input"

    invoke-virtual {p1, v0, v1}, Lcom/rokid/aicore/utils/LogUtil$Companion;->d(Ljava/lang/String;Ljava/lang/String;)V

    const/4 p1, 0x0

    return p1

    :cond_0
    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mFaceEngine:Lcom/rokid/aicore/api/engines/FaceEngine;

    const/4 v1, 0x0

    if-nez v0, :cond_1

    move-object v0, v1

    goto :goto_0

    :cond_1
    invoke-virtual {v0}, Lcom/rokid/aicore/api/engines/BaseEngine;->isEnable()Z

    move-result v0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    :goto_0
    sget-object v2, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-static {v0, v2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mFaceEngine:Lcom/rokid/aicore/api/engines/FaceEngine;

    if-nez v0, :cond_2

    goto :goto_1

    :cond_2
    invoke-virtual {v0, p1}, Lcom/rokid/aicore/api/engines/BaseEngine;->processBuffer(Lcom/rokid/aicore/api/bean/BufferImageInput;)Z

    :cond_3
    :goto_1
    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mLprEngine:Lcom/rokid/aicore/api/engines/LPREngine;

    if-nez v0, :cond_4

    move-object v0, v1

    goto :goto_2

    :cond_4
    invoke-virtual {v0}, Lcom/rokid/aicore/api/engines/BaseEngine;->isEnable()Z

    move-result v0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    :goto_2
    invoke-static {v0, v2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_6

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mLprEngine:Lcom/rokid/aicore/api/engines/LPREngine;

    if-nez v0, :cond_5

    goto :goto_3

    :cond_5
    invoke-virtual {v0, p1}, Lcom/rokid/aicore/api/engines/BaseEngine;->processBuffer(Lcom/rokid/aicore/api/bean/BufferImageInput;)Z

    :cond_6
    :goto_3
    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mMotorLprEngine:Lcom/rokid/aicore/api/engines/MotorLPREngine;

    if-nez v0, :cond_7

    goto :goto_4

    :cond_7
    invoke-virtual {v0}, Lcom/rokid/aicore/api/engines/BaseEngine;->isEnable()Z

    move-result v0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    :goto_4
    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_9

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mMotorLprEngine:Lcom/rokid/aicore/api/engines/MotorLPREngine;

    if-nez v0, :cond_8

    goto :goto_5

    :cond_8
    invoke-virtual {v0, p1}, Lcom/rokid/aicore/api/engines/BaseEngine;->processBuffer(Lcom/rokid/aicore/api/bean/BufferImageInput;)Z

    :cond_9
    :goto_5
    const/4 p1, 0x1

    return p1
.end method

.method public final processFaceRecognize(Lcom/rokid/aicore/api/bean/RecognizeDataInput;)Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;
    .locals 4

    const-string v0, "imageInput"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v0, p1, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->data:[B

    const-string v1, "####AIEngine"

    const/4 v2, 0x0

    if-eqz v0, :cond_5

    if-nez v0, :cond_0

    move-object v0, v2

    goto :goto_1

    :cond_0
    array-length v0, v0

    if-nez v0, :cond_1

    const/4 v0, 0x1

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    :goto_0
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    :goto_1
    sget-object v3, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-static {v0, v3}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    goto :goto_4

    :cond_2
    iget-object v0, p1, Lcom/rokid/aicore/api/bean/RecognizeDataInput;->type:Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;

    invoke-virtual {v0}, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;->ordinal()I

    move-result v0

    if-gez v0, :cond_3

    sget-object p1, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    const-string v0, "processFaceRecognize error.ImageInput type is error "

    :goto_2
    invoke-virtual {p1, v1, v0}, Lcom/rokid/aicore/utils/LogUtil$Companion;->d(Ljava/lang/String;Ljava/lang/String;)V

    return-object v2

    :cond_3
    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mFaceRecogEngine:Lcom/rokid/aicore/api/engines/FaceRecogEngine;

    if-nez v0, :cond_4

    goto :goto_3

    :cond_4
    invoke-virtual {v0, p1}, Lcom/rokid/aicore/api/engines/FaceRecogEngine;->process(Lcom/rokid/aicore/api/bean/RecognizeDataInput;)Lcom/rokid/aicore/api/callback/result/face/FaceRecognizeResult;

    move-result-object v2

    :goto_3
    return-object v2

    :cond_5
    :goto_4
    sget-object p1, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    const-string v0, "processFaceRecognize error.imageInput is null"

    goto :goto_2
.end method

.method public removeAllObservers()V
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mLprObservers:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mFaceObservers:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    return-void
.end method

.method public final removeFaceFeature(Ljava/lang/String;)V
    .locals 1

    const-string v0, "featureName"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mFaceEngine:Lcom/rokid/aicore/api/engines/FaceEngine;

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {v0, p1}, Lcom/rokid/aicore/api/engines/FaceEngine;->removeFeatureLibrary(Ljava/lang/String;)I

    :goto_0
    return-void
.end method

.method public final removeFaceRecogFeature(Ljava/lang/String;)V
    .locals 1

    const-string v0, "featureName"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mFaceRecogEngine:Lcom/rokid/aicore/api/engines/FaceRecogEngine;

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {v0, p1}, Lcom/rokid/aicore/api/engines/FaceRecogEngine;->removeFeatureLibrary(Ljava/lang/String;)I

    :goto_0
    return-void
.end method

.method public final removeMotorLPRProcessCallback()V
    .locals 2

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mMotorLPRProcessCallback:Lcom/rokid/aicore/api/callback/result/MotorLPRProcessCallback;

    iget-object v1, p0, Lcom/rokid/aicore/api/AIEngine;->mMotorLprEngine:Lcom/rokid/aicore/api/engines/MotorLPREngine;

    if-nez v1, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {v1, v0}, Lcom/rokid/aicore/api/engines/MotorLPREngine;->setExternalProcessCallback(Lcom/rokid/aicore/api/callback/result/MotorLPRProcessCallback;)V

    :goto_0
    return-void
.end method

.method public removeMotorObserver(Lcom/rokid/aicore/api/callback/LPRCallback;)V
    .locals 1

    const-string v0, "lprCallback"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mMotorLprObservers:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mMotorLprObservers:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    :cond_0
    return-void
.end method

.method public removeObserver(Lcom/rokid/aicore/api/callback/LPRCallback;)V
    .locals 1

    const-string v0, "lprCallback"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mLprObservers:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mLprObservers:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    :cond_0
    return-void
.end method

.method public removeObserver(Lcom/rokid/aicore/api/callback/face/FaceCallback;)V
    .locals 1

    const-string v0, "faceCallback"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mFaceObservers:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mFaceObservers:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    :cond_0
    return-void
.end method

.method public final setFaceFeatureFile(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    const-string v0, "featureName"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "featurePath"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mFaceEngine:Lcom/rokid/aicore/api/engines/FaceEngine;

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {v0, p1, p2}, Lcom/rokid/aicore/api/engines/FaceEngine;->setFeatureLibrary(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void
.end method

.method public final setFaceRecogFeatureFile(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    const-string v0, "featureName"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "featurePath"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mFaceRecogEngine:Lcom/rokid/aicore/api/engines/FaceRecogEngine;

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {v0, p1, p2}, Lcom/rokid/aicore/api/engines/FaceRecogEngine;->setFeatureLibrary(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void
.end method

.method public final setLPRRectThreshold(II)V
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mLprEngine:Lcom/rokid/aicore/api/engines/LPREngine;

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {v0, p1, p2}, Lcom/rokid/aicore/api/engines/LPREngine;->setLPRRectThreshold(II)V

    :goto_0
    return-void
.end method

.method public final setLprCharGoodEnoughThreshold(F)V
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mLprEngine:Lcom/rokid/aicore/api/engines/LPREngine;

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {v0, p1}, Lcom/rokid/aicore/api/engines/LPREngine;->setPlatCharGoodEnough(F)V

    :goto_0
    return-void
.end method

.method public final setMotorLPRProcessCallback(Lcom/rokid/aicore/api/callback/result/MotorLPRProcessCallback;)V
    .locals 1

    const-string v0, "callback"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    iput-object p1, p0, Lcom/rokid/aicore/api/AIEngine;->mMotorLPRProcessCallback:Lcom/rokid/aicore/api/callback/result/MotorLPRProcessCallback;

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mMotorLprEngine:Lcom/rokid/aicore/api/engines/MotorLPREngine;

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {v0, p1}, Lcom/rokid/aicore/api/engines/MotorLPREngine;->setExternalProcessCallback(Lcom/rokid/aicore/api/callback/result/MotorLPRProcessCallback;)V

    :goto_0
    return-void
.end method

.method public final setMotorLPRRectThreshold(II)V
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/api/AIEngine;->mMotorLprEngine:Lcom/rokid/aicore/api/engines/MotorLPREngine;

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {v0, p1, p2}, Lcom/rokid/aicore/api/engines/MotorLPREngine;->setMotorLPRRectThreshold(II)V

    :goto_0
    return-void
.end method
