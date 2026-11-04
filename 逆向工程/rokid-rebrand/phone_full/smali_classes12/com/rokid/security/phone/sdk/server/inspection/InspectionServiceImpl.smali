.class public final Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;
.super Ljava/lang/Object;
.source "InspectionServiceImpl.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nInspectionServiceImpl.kt\nKotlin\n*S Kotlin\n*F\n+ 1 InspectionServiceImpl.kt\ncom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl\n+ 2 _Maps.kt\nkotlin/collections/MapsKt___MapsKt\n+ 3 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,894:1\n215#2:895\n215#2:896\n216#2:900\n216#2:904\n766#3:897\n857#3,2:898\n1726#3,3:901\n1855#3:905\n1747#3,3:906\n1856#3:909\n1855#3,2:910\n*S KotlinDebug\n*F\n+ 1 InspectionServiceImpl.kt\ncom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl\n*L\n171#1:895\n175#1:896\n175#1:900\n171#1:904\n181#1:897\n181#1:898,2\n204#1:901,3\n471#1:905\n472#1:906,3\n471#1:909\n842#1:910,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u00b5\u0001\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\t\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0005\n\u0002\u0010\u000b\n\u0002\u0008\r\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u000b\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0006\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u0002\n\u0002\u0008\u0008\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u000b\n\u0002\u0010\u0012\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\t\n\u0002\u0018\u0002\n\u0002\u0008\u000b*\u00019\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0006\u0010Q\u001a\u00020RJ\u0006\u0010S\u001a\u00020RJ\u000e\u0010T\u001a\u00020R2\u0006\u0010U\u001a\u00020\u0006J \u0010V\u001a\u00020R2\u0006\u0010U\u001a\u00020\u00062\u0008\u0010W\u001a\u0004\u0018\u00010\u00062\u0006\u0010X\u001a\u00020\u000cJ\u000e\u0010Y\u001a\u00020R2\u0006\u0010Z\u001a\u00020[J\u0006\u0010\\\u001a\u00020RJ\u0006\u0010]\u001a\u00020^J\u0010\u0010_\u001a\u00020\u000c2\u0006\u0010`\u001a\u00020\u0006H\u0002J\u0015\u0010a\u001a\u0004\u0018\u00010\u00042\u0006\u0010b\u001a\u00020\u0006\u00a2\u0006\u0002\u0010cJ\u0010\u0010d\u001a\u00020R2\u0006\u0010e\u001a\u00020\u0006H\u0002J\u0006\u0010f\u001a\u00020RJ\u000e\u0010g\u001a\u00020\u000c2\u0006\u0010`\u001a\u00020\u0006J*\u0010h\u001a\u0004\u0018\u00010#2\u0006\u0010i\u001a\u00020j2\u0006\u0010k\u001a\u00020l2\u0006\u0010m\u001a\u00020l2\u0006\u0010n\u001a\u00020#H\u0002J\u000e\u0010o\u001a\u00020R2\u0006\u0010Z\u001a\u00020[J\u000e\u0010p\u001a\u00020R2\u0006\u0010q\u001a\u00020\u0006J \u0010K\u001a\u00020R2\u0006\u0010r\u001a\u00020j2\u0006\u0010k\u001a\u00020l2\u0006\u0010m\u001a\u00020lH\u0002J\u0006\u0010s\u001a\u00020RJ\u001a\u0010t\u001a\u00020R2\u0008\u0010u\u001a\u0004\u0018\u00010v2\u0006\u0010w\u001a\u00020\u000cH\u0002J\u0008\u0010x\u001a\u00020RH\u0002J\u0006\u0010y\u001a\u00020RJ\u0006\u0010z\u001a\u00020RJ\u0006\u0010{\u001a\u00020RJ\u000e\u0010|\u001a\u00020R2\u0006\u0010Z\u001a\u00020[J\u000e\u0010}\u001a\u00020R2\u0006\u0010Z\u001a\u00020[J\u000e\u0010~\u001a\u00020R2\u0006\u0010W\u001a\u00020\u0006J\u000e\u0010\u007f\u001a\u00020R2\u0006\u0010Z\u001a\u00020[J\u0007\u0010\u0080\u0001\u001a\u00020RR\u000e\u0010\u0003\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u001a\u0010\u0005\u001a\u00020\u0006X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0007\u0010\u0008\"\u0004\u0008\t\u0010\nR\u001a\u0010\u000b\u001a\u00020\u000cX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\r\u0010\u000e\"\u0004\u0008\u000f\u0010\u0010R\u001a\u0010\u0011\u001a\u00020\u000cX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0012\u0010\u000e\"\u0004\u0008\u0013\u0010\u0010R\u001a\u0010\u0014\u001a\u00020\u0006X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0015\u0010\u0008\"\u0004\u0008\u0016\u0010\nR\u000e\u0010\u0017\u001a\u00020\u000cX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0018\u001a\u00020\u0006X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0019\u001a\u00020\u001aX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u001b\u001a\u00020\u001aX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u001a\u0010\u001c\u001a\u00020\u001dX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u001e\u0010\u001f\"\u0004\u0008 \u0010!R\u0010\u0010\"\u001a\u0004\u0018\u00010#X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u001a\u0010$\u001a\u00020\u0006X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008%\u0010\u0008\"\u0004\u0008&\u0010\nR\u000e\u0010\'\u001a\u00020(X\u0082.\u00a2\u0006\u0002\n\u0000R\u000e\u0010)\u001a\u00020*X\u0082.\u00a2\u0006\u0002\n\u0000R\u0010\u0010+\u001a\u0004\u0018\u00010#X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010,\u001a\u00020-X\u0082.\u00a2\u0006\u0002\n\u0000R\u000e\u0010.\u001a\u00020\u000cX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010/\u001a\u00020\u000cX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u00100\u001a\u00020\u000cX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u001a\u00101\u001a\u00020\u000cX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u00081\u0010\u000e\"\u0004\u00082\u0010\u0010R\u000e\u00103\u001a\u00020\u0004X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u00104\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u001a\u00105\u001a\u00020\u0006X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u00086\u0010\u0008\"\u0004\u00087\u0010\nR\u0010\u00108\u001a\u000209X\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010:R\u0010\u0010;\u001a\u0004\u0018\u00010<X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010=\u001a\u00020>X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010?\u001a\u0004\u0018\u00010@X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010A\u001a\u00020BX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u001a\u0010C\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008D\u0010E\"\u0004\u0008F\u0010GR\u0016\u0010H\u001a\n J*\u0004\u0018\u00010I0IX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010K\u001a\u00020LX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010M\u001a\u0004\u0018\u00010NX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010O\u001a\u00020\u0001X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010P\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0081\u0001"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;",
        "",
        "()V",
        "HEARTBEAT_TIMEOUT_MS",
        "",
        "OfflineImagePath",
        "",
        "getOfflineImagePath",
        "()Ljava/lang/String;",
        "setOfflineImagePath",
        "(Ljava/lang/String;)V",
        "OfflineIsNormal",
        "",
        "getOfflineIsNormal",
        "()Z",
        "setOfflineIsNormal",
        "(Z)V",
        "OfflineTakePictureFlag",
        "getOfflineTakePictureFlag",
        "setOfflineTakePictureFlag",
        "OfflineTaskID",
        "getOfflineTaskID",
        "setOfflineTaskID",
        "PiceRecord",
        "TAG",
        "bollScope",
        "Lkotlinx/coroutines/CoroutineScope;",
        "defaultScope",
        "fileSystemUploadListener",
        "Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;",
        "getFileSystemUploadListener",
        "()Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;",
        "setFileSystemUploadListener",
        "(Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;)V",
        "guideSessionDir",
        "Ljava/io/File;",
        "guideSessionId",
        "getGuideSessionId",
        "setGuideSessionId",
        "imageUploadManager",
        "Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;",
        "inspectionDataManager",
        "Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;",
        "inspectionDir",
        "inspectionVideoUploader",
        "Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;",
        "isGlobalRecording",
        "isInspect",
        "isNeedQRCode",
        "isOfflineRecord",
        "setOfflineRecord",
        "lastHeartbeatAt",
        "lastImagePath",
        "lastState",
        "getLastState",
        "setLastState",
        "mInterMessageListener",
        "com/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$mInterMessageListener$1",
        "Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$mInterMessageListener$1;",
        "mOkHttpSSEClient",
        "Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;",
        "messageHandlerManager",
        "Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandlerManager;",
        "offlineRecorder",
        "Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;",
        "pendingTakePicture",
        "Ljava/util/concurrent/atomic/AtomicBoolean;",
        "piceVideoTime",
        "getPiceVideoTime",
        "()J",
        "setPiceVideoTime",
        "(J)V",
        "pictureWorker",
        "Ljava/util/concurrent/ExecutorService;",
        "kotlin.jvm.PlatformType",
        "qrCodeAnalyzer",
        "Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer;",
        "recorder",
        "Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;",
        "recorderLock",
        "takePictureId",
        "EndManualRecording",
        "",
        "GlobalRecording",
        "OfflineTaskEndAction",
        "taskID",
        "OfflineTaskStartAction",
        "sessionId",
        "isNormal",
        "StartManualRecording",
        "extra",
        "Lcom/rokid/security/sdk/base/common/AiChatExtra;",
        "baseInfoComplete",
        "bollEvent",
        "Lkotlinx/coroutines/Job;",
        "containsFilePath",
        "path",
        "getFileNameAsLong",
        "filePath",
        "(Ljava/lang/String;)Ljava/lang/Long;",
        "handleInspectGuideMessage",
        "message",
        "init",
        "judgeOverSizeFile",
        "nv21ToJpeg",
        "nv21Data",
        "",
        "width",
        "",
        "height",
        "outputFile",
        "onHeartbeat",
        "onMessage",
        "msg",
        "data",
        "release",
        "sendChatContent",
        "content",
        "Lcom/rokid/security/sdk/base/common/aichat/AiContent;",
        "isFinish",
        "sendError",
        "startQRcodeRec",
        "stopGlobalRecording",
        "stopPiceRecording",
        "toGuideAiChat",
        "toInspect",
        "toInspectEnd",
        "toTakePicture",
        "uploadImgList",
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
.field private static final HEARTBEAT_TIMEOUT_MS:J = 0x36b0L

.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

.field private static OfflineImagePath:Ljava/lang/String; = null

.field private static OfflineIsNormal:Z = false

.field private static OfflineTakePictureFlag:Z = false

.field private static OfflineTaskID:Ljava/lang/String; = null

.field private static PiceRecord:Z = false

.field private static final TAG:Ljava/lang/String; = "InspectionServiceImpl"

.field private static final bollScope:Lkotlinx/coroutines/CoroutineScope;

.field private static final defaultScope:Lkotlinx/coroutines/CoroutineScope;

.field private static fileSystemUploadListener:Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;

.field private static guideSessionDir:Ljava/io/File;

.field private static guideSessionId:Ljava/lang/String;

.field private static imageUploadManager:Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;

.field private static inspectionDataManager:Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;

.field private static inspectionDir:Ljava/io/File;

.field private static inspectionVideoUploader:Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;

.field private static volatile isGlobalRecording:Z

.field private static volatile isInspect:Z

.field private static isNeedQRCode:Z

.field private static isOfflineRecord:Z

.field private static volatile lastHeartbeatAt:J

.field private static lastImagePath:Ljava/lang/String;

.field private static lastState:Ljava/lang/String;

.field private static final mInterMessageListener:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$mInterMessageListener$1;

.field private static mOkHttpSSEClient:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

.field private static final messageHandlerManager:Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandlerManager;

.field private static offlineRecorder:Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;

.field private static final pendingTakePicture:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private static piceVideoTime:J

.field private static final pictureWorker:Ljava/util/concurrent/ExecutorService;

.field private static final qrCodeAnalyzer:Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer;

.field private static recorder:Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;

.field private static final recorderLock:Ljava/lang/Object;

.field private static volatile takePictureId:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    new-instance v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    .line 52
    const-string v0, "default"

    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->guideSessionId:Ljava/lang/String;

    .line 53
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getDefault()Lkotlinx/coroutines/CoroutineDispatcher;

    move-result-object v0

    check-cast v0, Lkotlin/coroutines/CoroutineContext;

    invoke-static {v0}, Lkotlinx/coroutines/CoroutineScopeKt;->CoroutineScope(Lkotlin/coroutines/CoroutineContext;)Lkotlinx/coroutines/CoroutineScope;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->defaultScope:Lkotlinx/coroutines/CoroutineScope;

    .line 60
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->pendingTakePicture:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 62
    const-string v0, ""

    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->takePictureId:Ljava/lang/String;

    .line 63
    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->lastImagePath:Ljava/lang/String;

    .line 64
    invoke-static {}, Ljava/util/concurrent/Executors;->newSingleThreadExecutor()Ljava/util/concurrent/ExecutorService;

    move-result-object v1

    sput-object v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->pictureWorker:Ljava/util/concurrent/ExecutorService;

    .line 73
    new-instance v1, Ljava/lang/Object;

    invoke-direct {v1}, Ljava/lang/Object;-><init>()V

    sput-object v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->recorderLock:Ljava/lang/Object;

    .line 75
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getIO()Lkotlinx/coroutines/CoroutineDispatcher;

    move-result-object v1

    check-cast v1, Lkotlin/coroutines/CoroutineContext;

    invoke-static {v1}, Lkotlinx/coroutines/CoroutineScopeKt;->CoroutineScope(Lkotlin/coroutines/CoroutineContext;)Lkotlinx/coroutines/CoroutineScope;

    move-result-object v1

    sput-object v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->bollScope:Lkotlinx/coroutines/CoroutineScope;

    .line 80
    sget-object v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer;

    sput-object v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->qrCodeAnalyzer:Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer;

    .line 82
    new-instance v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$fileSystemUploadListener$1;

    invoke-direct {v1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$fileSystemUploadListener$1;-><init>()V

    check-cast v1, Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;

    sput-object v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->fileSystemUploadListener:Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;

    .line 242
    new-instance v1, Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandlerManager;

    sget-object v2, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    invoke-direct {v1, v2}, Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandlerManager;-><init>(Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;)V

    sput-object v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->messageHandlerManager:Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandlerManager;

    .line 274
    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->lastState:Ljava/lang/String;

    .line 310
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    sput-wide v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->piceVideoTime:J

    .line 311
    new-instance v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$mInterMessageListener$1;

    invoke-direct {v1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$mInterMessageListener$1;-><init>()V

    sput-object v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$mInterMessageListener$1;

    .line 649
    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->OfflineTaskID:Ljava/lang/String;

    .line 652
    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->OfflineImagePath:Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 49
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static final synthetic access$containsFilePath(Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;Ljava/lang/String;)Z
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;
    .param p1, "path"    # Ljava/lang/String;

    .line 49
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->containsFilePath(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public static final synthetic access$getGuideSessionDir$p()Ljava/io/File;
    .locals 1

    .line 49
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->guideSessionDir:Ljava/io/File;

    return-object v0
.end method

.method public static final synthetic access$getImageUploadManager$p()Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;
    .locals 1

    .line 49
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->imageUploadManager:Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;

    return-object v0
.end method

.method public static final synthetic access$getInspectionDataManager$p()Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;
    .locals 1

    .line 49
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->inspectionDataManager:Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;

    return-object v0
.end method

.method public static final synthetic access$getInspectionVideoUploader$p()Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;
    .locals 1

    .line 49
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->inspectionVideoUploader:Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;

    return-object v0
.end method

.method public static final synthetic access$getLastHeartbeatAt$p()J
    .locals 2

    .line 49
    sget-wide v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->lastHeartbeatAt:J

    return-wide v0
.end method

.method public static final synthetic access$getMOkHttpSSEClient$p()Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;
    .locals 1

    .line 49
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->mOkHttpSSEClient:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    return-object v0
.end method

.method public static final synthetic access$getOfflineRecorder$p()Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;
    .locals 1

    .line 49
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->offlineRecorder:Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;

    return-object v0
.end method

.method public static final synthetic access$getPendingTakePicture$p()Ljava/util/concurrent/atomic/AtomicBoolean;
    .locals 1

    .line 49
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->pendingTakePicture:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-object v0
.end method

.method public static final synthetic access$getPiceRecord$p()Z
    .locals 1

    .line 49
    sget-boolean v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->PiceRecord:Z

    return v0
.end method

.method public static final synthetic access$getPictureWorker$p()Ljava/util/concurrent/ExecutorService;
    .locals 1

    .line 49
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->pictureWorker:Ljava/util/concurrent/ExecutorService;

    return-object v0
.end method

.method public static final synthetic access$getRecorder$p()Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;
    .locals 1

    .line 49
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->recorder:Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;

    return-object v0
.end method

.method public static final synthetic access$getRecorderLock$p()Ljava/lang/Object;
    .locals 1

    .line 49
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->recorderLock:Ljava/lang/Object;

    return-object v0
.end method

.method public static final synthetic access$getTakePictureId$p()Ljava/lang/String;
    .locals 1

    .line 49
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->takePictureId:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$handleInspectGuideMessage(Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;
    .param p1, "message"    # Ljava/lang/String;

    .line 49
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->handleInspectGuideMessage(Ljava/lang/String;)V

    return-void
.end method

.method public static final synthetic access$isGlobalRecording$p()Z
    .locals 1

    .line 49
    sget-boolean v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->isGlobalRecording:Z

    return v0
.end method

.method public static final synthetic access$isInspect$p()Z
    .locals 1

    .line 49
    sget-boolean v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->isInspect:Z

    return v0
.end method

.method public static final synthetic access$nv21ToJpeg(Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;[BIILjava/io/File;)Ljava/io/File;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;
    .param p1, "nv21Data"    # [B
    .param p2, "width"    # I
    .param p3, "height"    # I
    .param p4, "outputFile"    # Ljava/io/File;

    .line 49
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->nv21ToJpeg([BIILjava/io/File;)Ljava/io/File;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$qrCodeAnalyzer(Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;[BII)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;
    .param p1, "data"    # [B
    .param p2, "width"    # I
    .param p3, "height"    # I

    .line 49
    invoke-direct {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->qrCodeAnalyzer([BII)V

    return-void
.end method

.method public static final synthetic access$sendChatContent(Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;Lcom/rokid/security/sdk/base/common/aichat/AiContent;Z)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;
    .param p1, "content"    # Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    .param p2, "isFinish"    # Z

    .line 49
    invoke-direct {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->sendChatContent(Lcom/rokid/security/sdk/base/common/aichat/AiContent;Z)V

    return-void
.end method

.method public static final synthetic access$sendError(Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    .line 49
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->sendError()V

    return-void
.end method

.method public static final synthetic access$setInspect$p(Z)V
    .locals 0
    .param p0, "<set-?>"    # Z

    .line 49
    sput-boolean p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->isInspect:Z

    return-void
.end method

.method public static final synthetic access$setNeedQRCode$p(Z)V
    .locals 0
    .param p0, "<set-?>"    # Z

    .line 49
    sput-boolean p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->isNeedQRCode:Z

    return-void
.end method

.method public static final synthetic access$setRecorder$p(Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;)V
    .locals 0
    .param p0, "<set-?>"    # Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;

    .line 49
    sput-object p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->recorder:Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;

    return-void
.end method

.method public static final synthetic access$setTakePictureId$p(Ljava/lang/String;)V
    .locals 0
    .param p0, "<set-?>"    # Ljava/lang/String;

    .line 49
    sput-object p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->takePictureId:Ljava/lang/String;

    return-void
.end method

.method private final containsFilePath(Ljava/lang/String;)Z
    .locals 17
    .param p1, "path"    # Ljava/lang/String;

    .line 470
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->inspectionDataManager:Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;

    if-nez v0, :cond_0

    const-string v0, "inspectionDataManager"

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    const/4 v0, 0x0

    :cond_0
    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->readInspectionData()Ljava/util/Map;

    move-result-object v0

    .line 471
    .local v0, "imageInfoDict":Ljava/util/Map;
    invoke-interface {v0}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v1

    check-cast v1, Ljava/lang/Iterable;

    .local v1, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v2, 0x0

    .line 905
    .local v2, "$i$f$forEach":I
    invoke-interface {v1}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_5

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    .local v4, "element$iv":Ljava/lang/Object;
    move-object v6, v4

    check-cast v6, Ljava/util/Map;

    .local v6, "subMap":Ljava/util/Map;
    const/4 v7, 0x0

    .line 472
    .local v7, "$i$a$-forEach-InspectionServiceImpl$containsFilePath$1":I
    invoke-interface {v6}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v8

    check-cast v8, Ljava/lang/Iterable;

    .local v8, "$this$any$iv":Ljava/lang/Iterable;
    const/4 v9, 0x0

    .line 906
    .local v9, "$i$f$any":I
    instance-of v10, v8, Ljava/util/Collection;

    const/4 v11, 0x1

    if-eqz v10, :cond_1

    move-object v10, v8

    check-cast v10, Ljava/util/Collection;

    invoke-interface {v10}, Ljava/util/Collection;->isEmpty()Z

    move-result v10

    if-eqz v10, :cond_1

    move-object/from16 v5, p1

    const/16 v16, 0x0

    goto :goto_1

    .line 907
    :cond_1
    invoke-interface {v8}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v10

    :cond_2
    invoke-interface {v10}, Ljava/util/Iterator;->hasNext()Z

    move-result v12

    if-eqz v12, :cond_3

    invoke-interface {v10}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v12

    .local v12, "element$iv":Ljava/lang/Object;
    move-object v13, v12

    check-cast v13, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;

    .local v13, "it":Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;
    const/4 v14, 0x0

    .line 472
    .local v14, "$i$a$-any-InspectionServiceImpl$containsFilePath$1$1":I
    invoke-virtual {v13}, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;->getFilepath()Ljava/lang/String;

    move-result-object v15

    move-object/from16 v5, p1

    invoke-static {v15, v5}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v13

    .line 907
    .end local v13    # "it":Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;
    .end local v14    # "$i$a$-any-InspectionServiceImpl$containsFilePath$1$1":I
    if-eqz v13, :cond_2

    move/from16 v16, v11

    goto :goto_1

    .line 908
    .end local v12    # "element$iv":Ljava/lang/Object;
    :cond_3
    move-object/from16 v5, p1

    const/16 v16, 0x0

    .line 472
    .end local v8    # "$this$any$iv":Ljava/lang/Iterable;
    .end local v9    # "$i$f$any":I
    :goto_1
    if-eqz v16, :cond_4

    return v11

    .line 473
    :cond_4
    nop

    .line 905
    .end local v6    # "subMap":Ljava/util/Map;
    .end local v7    # "$i$a$-forEach-InspectionServiceImpl$containsFilePath$1":I
    nop

    .end local v4    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 909
    :cond_5
    move-object/from16 v5, p1

    .line 474
    .end local v1    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v2    # "$i$f$forEach":I
    const/4 v1, 0x0

    return v1
.end method

.method private final handleInspectGuideMessage(Ljava/lang/String;)V
    .locals 12
    .param p1, "message"    # Ljava/lang/String;

    .line 814
    const-string v0, "InspectionServiceImpl"

    move-object v1, p1

    check-cast v1, Ljava/lang/CharSequence;

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v1

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-nez v1, :cond_0

    move v1, v2

    goto :goto_0

    :cond_0
    move v1, v3

    :goto_0
    if-eqz v1, :cond_1

    .line 815
    return-void

    .line 818
    :cond_1
    nop

    .line 819
    :try_start_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "handleInspectMessage--> \u5de1\u67e5guide\u7ed3\u679c: "

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 823
    sget-object v1, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/aichat/AIChatServiceImpl;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    new-instance v4, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$handleInspectGuideMessage$response$1;

    invoke-direct {v4}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$handleInspectGuideMessage$response$1;-><init>()V

    invoke-virtual {v4}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$handleInspectGuideMessage$response$1;->getType()Ljava/lang/reflect/Type;

    move-result-object v4

    invoke-virtual {v1, p1, v4}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/reflect/Type;)Ljava/lang/Object;

    move-result-object v1

    const-string v4, "mGson.fromJson(message, \u20263<AIResponse>>() {}.type)"

    invoke-static {v1, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v1, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;

    .line 822
    nop

    .line 824
    .local v1, "response":Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;
    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getData()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;

    if-eqz v4, :cond_2

    invoke-virtual {v4}, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;->getSessionId()Ljava/lang/String;

    move-result-object v4

    goto :goto_1

    :cond_2
    const/4 v4, 0x0

    .line 827
    .local v4, "sessionId":Ljava/lang/String;
    :goto_1
    move-object v5, v4

    check-cast v5, Ljava/lang/CharSequence;

    if-eqz v5, :cond_4

    invoke-interface {v5}, Ljava/lang/CharSequence;->length()I

    move-result v5

    if-nez v5, :cond_3

    goto :goto_2

    :cond_3
    move v2, v3

    :cond_4
    :goto_2
    if-nez v2, :cond_5

    const-string v2, "default"

    invoke-static {v4, v2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_5

    .line 828
    sput-object v4, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->guideSessionId:Ljava/lang/String;

    .line 829
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v5, "\u66f4\u65b0audioSessionId: "

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v5, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->guideSessionId:Ljava/lang/String;

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 832
    new-instance v2, Ljava/io/File;

    sget-object v5, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->inspectionDir:Ljava/io/File;

    invoke-static {v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    sget-object v6, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->guideSessionId:Ljava/lang/String;

    invoke-direct {v2, v5, v6}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    sput-object v2, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->guideSessionDir:Ljava/io/File;

    .line 833
    sget-object v2, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->guideSessionDir:Ljava/io/File;

    invoke-static {v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v2

    if-nez v2, :cond_5

    .line 834
    sget-object v2, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->guideSessionDir:Ljava/io/File;

    invoke-static {v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v2}, Ljava/io/File;->mkdirs()Z

    .line 836
    nop

    .line 837
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Created guideSessionId directory: "

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v5, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->guideSessionDir:Ljava/io/File;

    invoke-static {v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v5}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 835
    invoke-static {v0, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 842
    :cond_5
    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;->getData()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;

    if-eqz v2, :cond_7

    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/aichat/AIResponse;->getMessage()Lcom/rokid/security/sdk/base/common/aichat/AiMessage;

    move-result-object v2

    if-eqz v2, :cond_7

    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/aichat/AiMessage;->getContents()Ljava/util/List;

    move-result-object v2

    if-eqz v2, :cond_7

    check-cast v2, Ljava/lang/Iterable;

    .local v2, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v5, 0x0

    .line 910
    .local v5, "$i$f$forEach":I
    invoke-interface {v2}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :goto_3
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_6

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    .local v7, "element$iv":Ljava/lang/Object;
    move-object v8, v7

    check-cast v8, Lcom/rokid/security/sdk/base/common/aichat/AiContent;

    .local v8, "it":Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    const/4 v9, 0x0

    .line 843
    .local v9, "$i$a$-forEach-InspectionServiceImpl$handleInspectGuideMessage$1":I
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "handleInspectMessage--> \u5de1\u68c0guide\u5185\u5bb9: "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v8}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getText()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v0, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 844
    sget-object v10, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->guideSessionId:Ljava/lang/String;

    invoke-virtual {v8, v10}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->setSessionId(Ljava/lang/String;)V

    .line 845
    sget-object v10, Lcom/rokid/security/sdk/base/common/aichat/AiContentType;->GUIDE:Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    invoke-virtual {v8, v10}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->setContentType(Lcom/rokid/security/sdk/base/common/aichat/AiContentType;)V

    .line 846
    sget-object v10, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    invoke-direct {v10, v8, v3}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->sendChatContent(Lcom/rokid/security/sdk/base/common/aichat/AiContent;Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 847
    nop

    .line 910
    .end local v8    # "it":Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    .end local v9    # "$i$a$-forEach-InspectionServiceImpl$handleInspectGuideMessage$1":I
    nop

    .end local v7    # "element$iv":Ljava/lang/Object;
    goto :goto_3

    .line 911
    :cond_6
    nop

    .end local v2    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v5    # "$i$f$forEach":I
    goto :goto_4

    .line 842
    .end local v1    # "response":Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse3;
    .end local v4    # "sessionId":Ljava/lang/String;
    :cond_7
    goto :goto_4

    .line 848
    :catch_0
    move-exception v1

    .line 849
    .local v1, "e":Ljava/lang/Exception;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "\u89e3\u6790\u5de1\u68c0guide\u54cd\u5e94\u5931\u8d25: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    move-object v3, v1

    check-cast v3, Ljava/lang/Throwable;

    invoke-static {v0, v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 850
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->sendError()V

    .line 852
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_4
    return-void
.end method

.method private final nv21ToJpeg([BIILjava/io/File;)Ljava/io/File;
    .locals 9
    .param p1, "nv21Data"    # [B
    .param p2, "width"    # I
    .param p3, "height"    # I
    .param p4, "outputFile"    # Ljava/io/File;

    .line 222
    const-string v0, "InspectionServiceImpl"

    .line 223
    const/4 v1, 0x0

    :try_start_0
    new-instance v8, Landroid/graphics/YuvImage;

    const/16 v4, 0x11

    const/4 v7, 0x0

    move-object v2, v8

    move-object v3, p1

    move v5, p2

    move v6, p3

    invoke-direct/range {v2 .. v7}, Landroid/graphics/YuvImage;-><init>([BIII[I)V

    move-object v2, v8

    .line 224
    .local v2, "yuvImage":Landroid/graphics/YuvImage;
    new-instance v3, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v3}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 225
    .local v3, "jpegOut":Ljava/io/ByteArrayOutputStream;
    new-instance v4, Landroid/graphics/Rect;

    const/4 v5, 0x0

    invoke-direct {v4, v5, v5, p2, p3}, Landroid/graphics/Rect;-><init>(IIII)V

    move-object v5, v3

    check-cast v5, Ljava/io/OutputStream;

    const/16 v6, 0x50

    invoke-virtual {v2, v4, v6, v5}, Landroid/graphics/YuvImage;->compressToJpeg(Landroid/graphics/Rect;ILjava/io/OutputStream;)Z

    .line 226
    invoke-virtual {v3}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v4

    .line 228
    .local v4, "jpegBytes":[B
    new-instance v5, Ljava/io/FileOutputStream;

    invoke-direct {v5, p4}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    check-cast v5, Ljava/io/Closeable;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    move-object v6, v5

    check-cast v6, Ljava/io/FileOutputStream;

    .local v6, "fos":Ljava/io/FileOutputStream;
    const/4 v7, 0x0

    .line 229
    .local v7, "$i$a$-use-InspectionServiceImpl$nv21ToJpeg$1":I
    invoke-virtual {v6, v4}, Ljava/io/FileOutputStream;->write([B)V

    .line 230
    invoke-virtual {v6}, Ljava/io/FileOutputStream;->flush()V

    .line 231
    nop

    .end local v6    # "fos":Ljava/io/FileOutputStream;
    .end local v7    # "$i$a$-use-InspectionServiceImpl$nv21ToJpeg$1":I
    sget-object v6, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 228
    :try_start_2
    invoke-static {v5, v1}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .line 233
    invoke-virtual {p4}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v5

    const-string v6, "outputFile.absolutePath"

    invoke-static {v5, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    sput-object v5, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->lastImagePath:Ljava/lang/String;

    .line 234
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Saved NV21 to JPG: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {p4}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v0, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    .line 235
    return-object p4

    .line 228
    :catchall_0
    move-exception v6

    .end local v2    # "yuvImage":Landroid/graphics/YuvImage;
    .end local v3    # "jpegOut":Ljava/io/ByteArrayOutputStream;
    .end local v4    # "jpegBytes":[B
    .end local p1    # "nv21Data":[B
    .end local p2    # "width":I
    .end local p3    # "height":I
    .end local p4    # "outputFile":Ljava/io/File;
    :try_start_3
    throw v6
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .restart local v2    # "yuvImage":Landroid/graphics/YuvImage;
    .restart local v3    # "jpegOut":Ljava/io/ByteArrayOutputStream;
    .restart local v4    # "jpegBytes":[B
    .restart local p1    # "nv21Data":[B
    .restart local p2    # "width":I
    .restart local p3    # "height":I
    .restart local p4    # "outputFile":Ljava/io/File;
    :catchall_1
    move-exception v7

    :try_start_4
    invoke-static {v5, v6}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .end local p1    # "nv21Data":[B
    .end local p2    # "width":I
    .end local p3    # "height":I
    .end local p4    # "outputFile":Ljava/io/File;
    throw v7
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0

    .line 236
    .end local v2    # "yuvImage":Landroid/graphics/YuvImage;
    .end local v3    # "jpegOut":Ljava/io/ByteArrayOutputStream;
    .end local v4    # "jpegBytes":[B
    .restart local p1    # "nv21Data":[B
    .restart local p2    # "width":I
    .restart local p3    # "height":I
    .restart local p4    # "outputFile":Ljava/io/File;
    :catch_0
    move-exception v2

    .line 237
    .local v2, "e":Ljava/lang/Exception;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Error converting NV21 to JPG: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v2}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    move-object v4, v2

    check-cast v4, Ljava/lang/Throwable;

    invoke-static {v0, v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 238
    return-object v1
.end method

.method private final qrCodeAnalyzer([BII)V
    .locals 7
    .param p1, "data"    # [B
    .param p2, "width"    # I
    .param p3, "height"    # I

    .line 436
    sget-boolean v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->isNeedQRCode:Z

    if-eqz v0, :cond_0

    .line 437
    sget-object v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->qrCodeAnalyzer:Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer;

    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$qrCodeAnalyzer$1;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$qrCodeAnalyzer$1;

    move-object v6, v0

    check-cast v6, Lkotlin/jvm/functions/Function1;

    const/4 v5, 0x0

    move-object v2, p1

    move v3, p2

    move v4, p3

    invoke-virtual/range {v1 .. v6}, Lcom/rokid/security/phone/sdk/server/inspection/InspectQrCodeAnalyzer;->onNv21Data([BIIILkotlin/jvm/functions/Function1;)V

    .line 467
    :cond_0
    return-void
.end method

.method private final sendChatContent(Lcom/rokid/security/sdk/base/common/aichat/AiContent;Z)V
    .locals 10
    .param p1, "content"    # Lcom/rokid/security/sdk/base/common/aichat/AiContent;
    .param p2, "isFinish"    # Z

    .line 862
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v1, "sendChatContent-->"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getText()Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " isFinish:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "InspectionServiceImpl"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 864
    new-instance v0, Lcom/rokid/security/sdk/base/common/AiChatExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/AiChatExtra;-><init>()V

    move-object v1, v0

    .local v1, "$this$sendChatContent_u24lambda_u2413":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    const/4 v2, 0x0

    .line 865
    .local v2, "$i$a$-apply-InspectionServiceImpl$sendChatContent$extra$1":I
    const-string v3, "onAiResponse"

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setMethodName(Ljava/lang/String;)V

    .line 866
    if-eqz p1, :cond_4

    .line 867
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getText()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setAnswer(Ljava/lang/String;)V

    .line 869
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getSessionId()Ljava/lang/String;

    move-result-object v3

    check-cast v3, Ljava/lang/CharSequence;

    if-eqz v3, :cond_2

    invoke-interface {v3}, Ljava/lang/CharSequence;->length()I

    move-result v3

    if-nez v3, :cond_1

    goto :goto_1

    :cond_1
    const/4 v3, 0x0

    goto :goto_2

    :cond_2
    :goto_1
    const/4 v3, 0x1

    :goto_2
    if-nez v3, :cond_3

    .line 870
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getSessionId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setSessionId(Ljava/lang/String;)V

    .line 872
    :cond_3
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/aichat/AiContent;->getContentType()Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setContentType(Lcom/rokid/security/sdk/base/common/aichat/AiContentType;)V

    .line 874
    :cond_4
    invoke-virtual {v1, p2}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setAnswerIsFinish(Z)V

    .line 875
    nop

    .line 864
    .end local v1    # "$this$sendChatContent_u24lambda_u2413":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    .end local v2    # "$i$a$-apply-InspectionServiceImpl$sendChatContent$extra$1":I
    nop

    .line 876
    .local v0, "extra":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 877
    .local v1, "extraStr":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v3, "extraStr"

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v8, 0x1c

    const/4 v9, 0x0

    const-string v3, "AI_CHAT_API_ACTION"

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v4, v1

    invoke-static/range {v2 .. v9}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 878
    return-void
.end method

.method private final sendError()V
    .locals 10

    .line 884
    const-string v0, "InspectionServiceImpl"

    const-string/jumbo v1, "sendError-->"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 886
    new-instance v0, Lcom/rokid/security/sdk/base/common/AiChatExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/AiChatExtra;-><init>()V

    move-object v1, v0

    .local v1, "$this$sendError_u24lambda_u2414":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    const/4 v2, 0x0

    .line 887
    .local v2, "$i$a$-apply-InspectionServiceImpl$sendError$extra$1":I
    const-string v3, "onError"

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setMethodName(Ljava/lang/String;)V

    .line 888
    nop

    .line 886
    .end local v1    # "$this$sendError_u24lambda_u2414":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    .end local v2    # "$i$a$-apply-InspectionServiceImpl$sendError$extra$1":I
    nop

    .line 889
    .local v0, "extra":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 890
    .local v1, "extraStr":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v3, "extraStr"

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v8, 0x1c

    const/4 v9, 0x0

    const-string v3, "AI_CHAT_API_ACTION"

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v4, v1

    invoke-static/range {v2 .. v9}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 891
    return-void
.end method


# virtual methods
.method public final EndManualRecording()V
    .locals 1

    .line 612
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->stopPiceRecording()V

    .line 613
    const/4 v0, 0x0

    sput-boolean v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->PiceRecord:Z

    .line 614
    return-void
.end method

.method public final GlobalRecording()V
    .locals 1

    .line 600
    const/4 v0, 0x1

    sput-boolean v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->isGlobalRecording:Z

    .line 601
    return-void
.end method

.method public final OfflineTaskEndAction(Ljava/lang/String;)V
    .locals 11
    .param p1, "taskID"    # Ljava/lang/String;

    const-string/jumbo v0, "taskID"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 686
    const/4 v0, 0x0

    sput-boolean v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->isOfflineRecord:Z

    .line 689
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->offlineRecorder:Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->stop()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_0
    move-object v0, v1

    .line 691
    .local v0, "wavPath":Ljava/lang/String;
    :goto_0
    sget-object v2, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->guideSessionDir:Ljava/io/File;

    invoke-static {v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v2}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v2

    .line 693
    .local v2, "subfolderName":Ljava/lang/String;
    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    .line 695
    sget-object v6, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->OfflineTaskID:Ljava/lang/String;

    .line 697
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v8

    .line 692
    new-instance v10, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;

    .line 693
    nop

    .line 696
    nop

    .line 695
    nop

    .line 694
    nop

    .line 697
    nop

    .line 692
    const-string v5, ""

    const-string v7, ""

    move-object v3, v10

    invoke-direct/range {v3 .. v9}, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V

    .line 699
    .local v3, "newInspectDataInfo":Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;
    sget-object v4, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->inspectionDataManager:Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;

    if-nez v4, :cond_1

    const-string v4, "inspectionDataManager"

    invoke-static {v4}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v4, v1

    :cond_1
    const-string/jumbo v5, "subfolderName"

    invoke-static {v2, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v4, v2, v3}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->addInspectInfo(Ljava/lang/String;Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;)V

    .line 701
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v5, "\u79bb\u7ebf\u5f55\u97f3\u5b8c\u6210\u6587\u4ef6: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    const-string v5, "InspectionServiceImpl"

    invoke-static {v5, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 703
    sput-object v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->offlineRecorder:Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;

    .line 704
    const-string v1, ""

    sput-object v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->OfflineTaskID:Ljava/lang/String;

    .line 705
    sput-object v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->OfflineImagePath:Ljava/lang/String;

    .line 706
    return-void
.end method

.method public final OfflineTaskStartAction(Ljava/lang/String;Ljava/lang/String;Z)V
    .locals 9
    .param p1, "taskID"    # Ljava/lang/String;
    .param p2, "sessionId"    # Ljava/lang/String;
    .param p3, "isNormal"    # Z

    const-string/jumbo v0, "taskID"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 656
    move-object v0, p2

    check-cast v0, Ljava/lang/CharSequence;

    const/4 v1, 0x1

    if-eqz v0, :cond_1

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    move v0, v1

    :goto_1
    if-nez v0, :cond_2

    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->guideSessionDir:Ljava/io/File;

    if-nez v0, :cond_2

    .line 657
    new-instance v0, Ljava/io/File;

    sget-object v2, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->inspectionDir:Ljava/io/File;

    invoke-static {v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-direct {v0, v2, p2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->guideSessionDir:Ljava/io/File;

    .line 658
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->guideSessionDir:Ljava/io/File;

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_2

    .line 659
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->guideSessionDir:Ljava/io/File;

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v0}, Ljava/io/File;->mkdirs()Z

    .line 661
    nop

    .line 662
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Created offline session directory: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->guideSessionDir:Ljava/io/File;

    invoke-static {v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 660
    const-string v2, "InspectionServiceImpl"

    invoke-static {v2, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 666
    :cond_2
    sput-boolean v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->isOfflineRecord:Z

    .line 668
    sput-boolean v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->OfflineTakePictureFlag:Z

    .line 669
    sput-boolean p3, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->OfflineIsNormal:Z

    .line 670
    sput-object p1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->OfflineTaskID:Ljava/lang/String;

    .line 671
    new-instance v0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;

    const/4 v7, 0x7

    const/4 v8, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v3, v0

    invoke-direct/range {v3 .. v8}, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;-><init>(IIIILkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->offlineRecorder:Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;

    .line 672
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->offlineRecorder:Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;

    if-eqz v0, :cond_3

    invoke-static {p2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1, p1}, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->start(Ljava/lang/String;Ljava/lang/String;)V

    .line 673
    :cond_3
    new-instance v0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultItem;

    .line 674
    nop

    .line 675
    sget-boolean v4, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->OfflineIsNormal:Z

    .line 673
    const/4 v7, 0x4

    const/4 v8, 0x0

    const-wide/16 v5, 0x0

    move-object v2, v0

    move-object v3, p1

    invoke-direct/range {v2 .. v8}, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultItem;-><init>(Ljava/lang/String;ZJILkotlin/jvm/internal/DefaultConstructorMarker;)V

    .line 678
    .local v0, "result":Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultItem;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultManager;

    invoke-static {p2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultManager;->saveResult(Ljava/lang/String;Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultItem;)V

    .line 679
    return-void
.end method

.method public final StartManualRecording(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V
    .locals 1
    .param p1, "extra"    # Lcom/rokid/security/sdk/base/common/AiChatExtra;

    const-string v0, "extra"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 604
    sget-boolean v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->isGlobalRecording:Z

    if-eqz v0, :cond_0

    .line 605
    return-void

    .line 607
    :cond_0
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getAnswer()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->takePictureId:Ljava/lang/String;

    .line 608
    const/4 v0, 0x1

    sput-boolean v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->PiceRecord:Z

    .line 609
    return-void
.end method

.method public final baseInfoComplete()V
    .locals 13

    .line 148
    new-instance v0, Lcom/rokid/security/sdk/base/common/aichat/FunctionBaseVO;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/aichat/FunctionBaseVO;-><init>()V

    move-object v1, v0

    .local v1, "$this$baseInfoComplete_u24lambda_u240":Lcom/rokid/security/sdk/base/common/aichat/FunctionBaseVO;
    const/4 v2, 0x0

    .line 149
    .local v2, "$i$a$-apply-InspectionServiceImpl$baseInfoComplete$fn$1":I
    const-string v3, "baseInfoComplete"

    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/aichat/FunctionBaseVO;->setType(Ljava/lang/String;)V

    .line 150
    nop

    .line 148
    .end local v1    # "$this$baseInfoComplete_u24lambda_u240":Lcom/rokid/security/sdk/base/common/aichat/FunctionBaseVO;
    .end local v2    # "$i$a$-apply-InspectionServiceImpl$baseInfoComplete$fn$1":I
    nop

    .line 151
    .local v0, "fn":Lcom/rokid/security/sdk/base/common/aichat/FunctionBaseVO;
    new-instance v9, Lcom/rokid/security/sdk/base/common/aichat/AiInspectionModel;

    invoke-static {v0}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v6

    const/16 v7, 0xf

    const/4 v8, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v1, v9

    invoke-direct/range {v1 .. v8}, Lcom/rokid/security/sdk/base/common/aichat/AiInspectionModel;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    .line 152
    .local v1, "model":Lcom/rokid/security/sdk/base/common/aichat/AiInspectionModel;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v2

    invoke-virtual {v2, v1}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 153
    .local v2, "answerJson":Ljava/lang/String;
    new-instance v3, Lcom/rokid/security/sdk/base/common/AiChatExtra;

    invoke-direct {v3}, Lcom/rokid/security/sdk/base/common/AiChatExtra;-><init>()V

    move-object v4, v3

    .local v4, "$this$baseInfoComplete_u24lambda_u241":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    const/4 v5, 0x0

    .line 154
    .local v5, "$i$a$-apply-InspectionServiceImpl$baseInfoComplete$extra$1":I
    const-string v6, "onAiResponse"

    invoke-virtual {v4, v6}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setMethodName(Ljava/lang/String;)V

    .line 155
    const-string v6, "answerJson"

    invoke-static {v2, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v4, v2}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setAnswer(Ljava/lang/String;)V

    .line 156
    const/4 v6, 0x0

    invoke-virtual {v4, v6}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setAnswerIsFinish(Z)V

    .line 157
    sget-object v6, Lcom/rokid/security/sdk/base/common/aichat/AiContentType;->GUIDE:Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    invoke-virtual {v4, v6}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setContentType(Lcom/rokid/security/sdk/base/common/aichat/AiContentType;)V

    .line 158
    sget-object v6, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->guideSessionId:Ljava/lang/String;

    invoke-virtual {v4, v6}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->setSessionId(Ljava/lang/String;)V

    .line 159
    nop

    .line 153
    .end local v4    # "$this$baseInfoComplete_u24lambda_u241":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    .end local v5    # "$i$a$-apply-InspectionServiceImpl$baseInfoComplete$extra$1":I
    nop

    .line 160
    .local v3, "extra":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    sget-object v4, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v4}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v4

    invoke-virtual {v4, v3}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    .line 161
    .local v4, "extraStr":Ljava/lang/String;
    sget-object v5, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v6, "extraStr"

    invoke-static {v4, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v11, 0x1c

    const/4 v12, 0x0

    const-string v6, "AI_CHAT_API_ACTION"

    const/4 v9, 0x0

    const/4 v10, 0x0

    move-object v7, v4

    invoke-static/range {v5 .. v12}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 162
    return-void
.end method

.method public final bollEvent()Lkotlinx/coroutines/Job;
    .locals 6

    .line 276
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->bollScope:Lkotlinx/coroutines/CoroutineScope;

    new-instance v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$bollEvent$1;

    const/4 v2, 0x0

    invoke-direct {v1, v2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$bollEvent$1;-><init>(Lkotlin/coroutines/Continuation;)V

    move-object v3, v1

    check-cast v3, Lkotlin/jvm/functions/Function2;

    const/4 v4, 0x3

    const/4 v5, 0x0

    const/4 v1, 0x0

    invoke-static/range {v0 .. v5}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    move-result-object v0

    .line 300
    return-object v0
.end method

.method public final getFileNameAsLong(Ljava/lang/String;)Ljava/lang/Long;
    .locals 6
    .param p1, "filePath"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 479
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v0

    .line 481
    .local v0, "fileNameWithExtension":Ljava/lang/String;
    const-string v1, "fileNameWithExtension"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/4 v1, 0x2

    const-string v2, "."

    const/4 v3, 0x0

    invoke-static {v0, v2, v3, v1, v3}, Lkotlin/text/StringsKt;->substringBeforeLast$default(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 483
    .local v1, "fileName":Ljava/lang/String;
    nop

    .line 484
    :try_start_0
    invoke-static {v1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v4

    invoke-static {v4, v5}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 485
    :catch_0
    move-exception v2

    .line 487
    .local v2, "e":Ljava/lang/NumberFormatException;
    invoke-virtual {v2}, Ljava/lang/NumberFormatException;->printStackTrace()V

    .line 488
    nop

    .line 483
    .end local v2    # "e":Ljava/lang/NumberFormatException;
    :goto_0
    return-object v3
.end method

.method public final getFileSystemUploadListener()Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;
    .locals 1

    .line 82
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->fileSystemUploadListener:Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;

    return-object v0
.end method

.method public final getGuideSessionId()Ljava/lang/String;
    .locals 1

    .line 52
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->guideSessionId:Ljava/lang/String;

    return-object v0
.end method

.method public final getLastState()Ljava/lang/String;
    .locals 1

    .line 274
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->lastState:Ljava/lang/String;

    return-object v0
.end method

.method public final getOfflineImagePath()Ljava/lang/String;
    .locals 1

    .line 652
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->OfflineImagePath:Ljava/lang/String;

    return-object v0
.end method

.method public final getOfflineIsNormal()Z
    .locals 1

    .line 650
    sget-boolean v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->OfflineIsNormal:Z

    return v0
.end method

.method public final getOfflineTakePictureFlag()Z
    .locals 1

    .line 653
    sget-boolean v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->OfflineTakePictureFlag:Z

    return v0
.end method

.method public final getOfflineTaskID()Ljava/lang/String;
    .locals 1

    .line 649
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->OfflineTaskID:Ljava/lang/String;

    return-object v0
.end method

.method public final getPiceVideoTime()J
    .locals 2

    .line 310
    sget-wide v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->piceVideoTime:J

    return-wide v0
.end method

.method public final init()V
    .locals 4

    .line 246
    const-string v0, "Inspection Service Initialized"

    const-string v1, "InspectionServiceImpl"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 247
    new-instance v0, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->mOkHttpSSEClient:Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;

    .line 248
    sget-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;

    sget-object v2, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->fileSystemUploadListener:Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;

    invoke-virtual {v0, v2}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->addFileUploadListener(Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;)V

    .line 249
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    sget-object v2, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$mInterMessageListener$1;

    check-cast v2, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    invoke-virtual {v0, v2}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->addInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V

    .line 252
    new-instance v0, Ljava/io/File;

    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v2

    invoke-virtual {v2}, Landroid/app/Application;->getFilesDir()Ljava/io/File;

    move-result-object v2

    const-string v3, "Inspection"

    invoke-direct {v0, v2, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->inspectionDir:Ljava/io/File;

    .line 253
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->inspectionDir:Ljava/io/File;

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_0

    .line 254
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->inspectionDir:Ljava/io/File;

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v0}, Ljava/io/File;->mkdirs()Z

    .line 255
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Created Inspection directory: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->inspectionDir:Ljava/io/File;

    invoke-static {v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 257
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Inspection directory: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->inspectionDir:Ljava/io/File;

    invoke-static {v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 259
    new-instance v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->inspectionDir:Ljava/io/File;

    invoke-static {v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-direct {v0, v1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;-><init>(Ljava/io/File;)V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->inspectionDataManager:Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;

    .line 262
    new-instance v0, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->inspectionDataManager:Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    const-string v1, "inspectionDataManager"

    invoke-static {v1}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v1, v2

    :cond_1
    sget-object v3, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$init$1;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$init$1;

    check-cast v3, Lkotlin/jvm/functions/Function0;

    invoke-direct {v0, v1, v3}, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;-><init>(Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;Lkotlin/jvm/functions/Function0;)V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->imageUploadManager:Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;

    .line 263
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->imageUploadManager:Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;

    if-nez v0, :cond_2

    const-string v0, "imageUploadManager"

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_0

    :cond_2
    move-object v2, v0

    :goto_0
    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->startUploads()V

    .line 265
    new-instance v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;

    .line 266
    invoke-static {}, Lcom/rokid/utils/ContextUtil;->getApplicationContext()Landroid/app/Application;

    move-result-object v1

    .line 267
    const-string v2, "inspection_cache"

    invoke-virtual {v1, v2}, Landroid/app/Application;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v1

    invoke-static {v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    .line 265
    sget-object v2, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$init$2;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$init$2;

    check-cast v2, Lkotlin/jvm/functions/Function0;

    invoke-direct {v0, v1, v2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;-><init>(Ljava/io/File;Lkotlin/jvm/functions/Function0;)V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->inspectionVideoUploader:Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager;

    .line 270
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->uploadImgList()V

    .line 271
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->bollEvent()Lkotlinx/coroutines/Job;

    .line 272
    return-void
.end method

.method public final isOfflineRecord()Z
    .locals 1

    .line 651
    sget-boolean v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->isOfflineRecord:Z

    return v0
.end method

.method public final judgeOverSizeFile(Ljava/lang/String;)Z
    .locals 10
    .param p1, "path"    # Ljava/lang/String;

    const-string v0, "path"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 557
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 558
    .local v0, "videoFile":Ljava/io/File;
    const-wide/32 v1, 0x40000000

    .line 559
    .local v1, "MAX_FILE_SIZE":J
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v3

    const/4 v4, 0x0

    if-eqz v3, :cond_2

    invoke-virtual {v0}, Ljava/io/File;->isFile()Z

    move-result v3

    if-eqz v3, :cond_2

    .line 560
    invoke-virtual {v0}, Ljava/io/File;->length()J

    move-result-wide v5

    .line 561
    .local v5, "fileSize":J
    cmp-long v3, v5, v1

    if-lez v3, :cond_1

    .line 562
    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    move-result v3

    .line 563
    .local v3, "isDeleted":Z
    const-string v7, "VideoUpload"

    if-eqz v3, :cond_0

    .line 565
    nop

    .line 566
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v9, "\u6587\u4ef6\u8fc7\u5927\uff08"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string/jumbo v9, "\u5b57\u8282\uff09\uff0c\u5df2\u5220\u9664\uff0c\u672a\u6267\u884c\u4e0a\u4f20: "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    .line 564
    invoke-static {v7, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 569
    :cond_0
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v9, "\u6587\u4ef6\u8fc7\u5927\uff0c\u4f46\u5220\u9664\u5931\u8d25: "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 572
    :goto_0
    return v4

    .line 574
    .end local v3    # "isDeleted":Z
    :cond_1
    const/4 v3, 0x1

    return v3

    .line 576
    .end local v5    # "fileSize":J
    :cond_2
    return v4
.end method

.method public final onHeartbeat(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V
    .locals 2
    .param p1, "extra"    # Lcom/rokid/security/sdk/base/common/AiChatExtra;

    const-string v0, "extra"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 530
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    sput-wide v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->lastHeartbeatAt:J

    .line 531
    const/4 v0, 0x1

    sput-boolean v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->isInspect:Z

    .line 532
    return-void
.end method

.method public final onMessage(Ljava/lang/String;)V
    .locals 6
    .param p1, "msg"    # Ljava/lang/String;

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 496
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const-string v1, "AI_CHAT_API_ACTION"

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x2

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-static {v0, v1, v4, v2, v3}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 497
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "onMessage:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x20

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "InspectionServiceImpl"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 498
    sget-object v0, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v0

    const-class v2, Lcom/rokid/security/sdk/base/common/RkBaseData;

    invoke-virtual {v0, p1, v2}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/base/common/RkBaseData;

    .line 500
    .local v0, "rkBaseData":Lcom/rokid/security/sdk/base/common/RkBaseData;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v2

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/RkBaseData;->getExtra()Ljava/lang/String;

    move-result-object v3

    const-class v5, Lcom/rokid/security/sdk/base/common/AiChatExtra;

    invoke-virtual {v2, v3, v5}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/rokid/security/sdk/base/common/AiChatExtra;

    .line 499
    nop

    .line 503
    .local v2, "mAiChatExtra":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getMethodName()Ljava/lang/String;

    move-result-object v3

    const-string/jumbo v5, "startAiChat"

    invoke-static {v3, v5}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 505
    const-string/jumbo v3, "\u542f\u52a8AI\u804a\u5929"

    invoke-static {v1, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 506
    return-void

    .line 508
    :cond_0
    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getMethodName()Ljava/lang/String;

    move-result-object v3

    const-string v5, "ToInspect"

    invoke-static {v3, v5}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 509
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "mAiChatExtra.question "

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getQuestion()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 511
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getQuestion()Ljava/lang/String;

    move-result-object v3

    const-class v5, Lcom/rokid/security/sdk/base/common/AiChatExtra;

    invoke-virtual {v1, v3, v5}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/rokid/security/sdk/base/common/AiChatExtra;

    .line 510
    nop

    .line 512
    .local v1, "extra":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getMethodName()Ljava/lang/String;

    move-result-object v3

    const-string v5, "guideAIChatBegin"

    invoke-static {v3, v5}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_2

    .line 513
    invoke-virtual {v1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getMethodName()Ljava/lang/String;

    move-result-object v3

    const-string v5, "guideAIChatEnd"

    invoke-static {v3, v5}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    goto :goto_0

    .line 516
    :cond_1
    const/4 v3, 0x1

    sput-boolean v3, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->isInspect:Z

    .line 517
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    sput-wide v3, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->lastHeartbeatAt:J

    goto :goto_1

    .line 514
    :cond_2
    :goto_0
    sput-boolean v4, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->isInspect:Z

    .line 520
    :goto_1
    sget-object v3, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->messageHandlerManager:Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandlerManager;

    const-string v4, "extra"

    invoke-static {v1, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v3, v1}, Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandlerManager;->handleMessage(Lcom/rokid/security/sdk/base/common/AiChatExtra;)Z

    goto :goto_2

    .line 523
    .end local v1    # "extra":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    :cond_3
    sget-object v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->messageHandlerManager:Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandlerManager;

    const-string v3, "mAiChatExtra"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v1, v2}, Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandlerManager;->handleMessage(Lcom/rokid/security/sdk/base/common/AiChatExtra;)Z

    .line 527
    .end local v0    # "rkBaseData":Lcom/rokid/security/sdk/base/common/RkBaseData;
    .end local v2    # "mAiChatExtra":Lcom/rokid/security/sdk/base/common/AiChatExtra;
    :cond_4
    :goto_2
    return-void
.end method

.method public final release()V
    .locals 2

    .line 304
    sget-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->fileSystemUploadListener:Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->removeFileUploadListener(Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;)V

    .line 305
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$mInterMessageListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->removeInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V

    .line 306
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->pictureWorker:Ljava/util/concurrent/ExecutorService;

    invoke-interface {v0}, Ljava/util/concurrent/ExecutorService;->shutdown()V

    .line 307
    sget-object v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->setWifiP2PMessageListener(Lcom/rokid/security/phone/sdk/api/wifip2p/listener/IWifiP2PMessageListener;)V

    .line 308
    return-void
.end method

.method public final setFileSystemUploadListener(Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;)V
    .locals 1
    .param p1, "<set-?>"    # Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 82
    sput-object p1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->fileSystemUploadListener:Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;

    .line 145
    return-void
.end method

.method public final setGuideSessionId(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 52
    sput-object p1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->guideSessionId:Ljava/lang/String;

    return-void
.end method

.method public final setLastState(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 274
    sput-object p1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->lastState:Ljava/lang/String;

    return-void
.end method

.method public final setOfflineImagePath(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 652
    sput-object p1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->OfflineImagePath:Ljava/lang/String;

    return-void
.end method

.method public final setOfflineIsNormal(Z)V
    .locals 0
    .param p1, "<set-?>"    # Z

    .line 650
    sput-boolean p1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->OfflineIsNormal:Z

    return-void
.end method

.method public final setOfflineRecord(Z)V
    .locals 0
    .param p1, "<set-?>"    # Z

    .line 651
    sput-boolean p1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->isOfflineRecord:Z

    return-void
.end method

.method public final setOfflineTakePictureFlag(Z)V
    .locals 0
    .param p1, "<set-?>"    # Z

    .line 653
    sput-boolean p1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->OfflineTakePictureFlag:Z

    return-void
.end method

.method public final setOfflineTaskID(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 649
    sput-object p1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->OfflineTaskID:Ljava/lang/String;

    return-void
.end method

.method public final setPiceVideoTime(J)V
    .locals 0
    .param p1, "<set-?>"    # J

    .line 310
    sput-wide p1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->piceVideoTime:J

    return-void
.end method

.method public final startQRcodeRec()V
    .locals 1

    .line 682
    const/4 v0, 0x1

    sput-boolean v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->isNeedQRCode:Z

    .line 683
    return-void
.end method

.method public final stopGlobalRecording()V
    .locals 4

    .line 536
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->uploadImgList()V

    .line 537
    sget-boolean v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->isGlobalRecording:Z

    if-nez v0, :cond_0

    .line 538
    return-void

    .line 540
    :cond_0
    const/4 v0, 0x0

    sput-boolean v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->isGlobalRecording:Z

    .line 541
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->recorderLock:Ljava/lang/Object;

    monitor-enter v0

    const/4 v1, 0x0

    .line 542
    .local v1, "$i$a$-synchronized-InspectionServiceImpl$stopGlobalRecording$1":I
    :try_start_0
    sget-object v2, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->recorder:Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;

    if-eqz v2, :cond_1

    sget-object v3, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$stopGlobalRecording$1$1;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$stopGlobalRecording$1$1;

    check-cast v3, Lkotlin/jvm/functions/Function1;

    invoke-virtual {v2, v3}, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->stop(Lkotlin/jvm/functions/Function1;)V

    sget-object v2, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 541
    .end local v1    # "$i$a$-synchronized-InspectionServiceImpl$stopGlobalRecording$1":I
    :cond_1
    monitor-exit v0

    .line 554
    return-void

    .line 541
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method public final stopPiceRecording()V
    .locals 4

    .line 618
    sget-boolean v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->PiceRecord:Z

    if-nez v0, :cond_0

    .line 619
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->uploadImgList()V

    .line 620
    return-void

    .line 622
    :cond_0
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->recorderLock:Ljava/lang/Object;

    monitor-enter v0

    const/4 v1, 0x0

    .line 623
    .local v1, "$i$a$-synchronized-InspectionServiceImpl$stopPiceRecording$1":I
    :try_start_0
    sget-object v2, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->recorder:Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;

    if-eqz v2, :cond_1

    sget-object v3, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$stopPiceRecording$1$1;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$stopPiceRecording$1$1;

    check-cast v3, Lkotlin/jvm/functions/Function1;

    invoke-virtual {v2, v3}, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->stop(Lkotlin/jvm/functions/Function1;)V

    sget-object v2, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    goto :goto_0

    :cond_1
    const/4 v2, 0x0

    :goto_0
    if-nez v2, :cond_2

    .line 642
    sget-object v2, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    .local v2, "$this$stopPiceRecording_u24lambda_u2411_u24lambda_u2410":Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;
    const/4 v3, 0x0

    .line 644
    .local v3, "$i$a$-run-InspectionServiceImpl$stopPiceRecording$1$2":I
    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->uploadImgList()V

    .line 645
    nop

    .line 642
    .end local v2    # "$this$stopPiceRecording_u24lambda_u2411_u24lambda_u2410":Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;
    .end local v3    # "$i$a$-run-InspectionServiceImpl$stopPiceRecording$1$2":I
    nop

    .line 646
    :cond_2
    nop

    .end local v1    # "$i$a$-synchronized-InspectionServiceImpl$stopPiceRecording$1":I
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 622
    monitor-exit v0

    .line 647
    return-void

    .line 622
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method public final toGuideAiChat(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V
    .locals 10
    .param p1, "extra"    # Lcom/rokid/security/sdk/base/common/AiChatExtra;

    const-string v0, "extra"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 765
    const/4 v0, 0x2

    new-array v0, v0, [Lkotlin/Pair;

    const-string/jumbo v1, "text"

    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getQuestion()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/4 v2, 0x0

    aput-object v1, v0, v2

    .line 766
    const-string v1, "promptType"

    const-string v2, "inspection"

    invoke-static {v1, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/4 v2, 0x1

    aput-object v1, v0, v2

    .line 765
    nop

    .line 764
    invoke-static {v0}, Lkotlin/collections/MapsKt;->mutableMapOf([Lkotlin/Pair;)Ljava/util/Map;

    move-result-object v0

    .line 768
    .local v0, "guideParamMap":Ljava/util/Map;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onGuideChatAi--> param: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "InspectionServiceImpl"

    invoke-static {v2, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 775
    new-instance v1, Lcom/google/gson/Gson;

    invoke-direct {v1}, Lcom/google/gson/Gson;-><init>()V

    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 776
    .local v1, "gauideParam":Ljava/lang/String;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "onChatAi--> gauideParam "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 777
    sget-object v4, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->defaultScope:Lkotlinx/coroutines/CoroutineScope;

    new-instance v2, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$toGuideAiChat$1;

    const/4 v3, 0x0

    invoke-direct {v2, v1, v3}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$toGuideAiChat$1;-><init>(Ljava/lang/String;Lkotlin/coroutines/Continuation;)V

    move-object v7, v2

    check-cast v7, Lkotlin/jvm/functions/Function2;

    const/4 v8, 0x3

    const/4 v9, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    invoke-static/range {v4 .. v9}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 811
    return-void
.end method

.method public final toInspect(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V
    .locals 10
    .param p1, "extra"    # Lcom/rokid/security/sdk/base/common/AiChatExtra;

    const-string v0, "extra"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 713
    const/4 v0, 0x2

    new-array v0, v0, [Lkotlin/Pair;

    const-string/jumbo v1, "text"

    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getQuestion()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/4 v2, 0x0

    aput-object v1, v0, v2

    .line 714
    const-string v1, "promptType"

    const-string v2, "inspection"

    invoke-static {v1, v2}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v1

    const/4 v2, 0x1

    aput-object v1, v0, v2

    .line 713
    nop

    .line 712
    invoke-static {v0}, Lkotlin/collections/MapsKt;->mutableMapOf([Lkotlin/Pair;)Ljava/util/Map;

    move-result-object v0

    .line 716
    .local v0, "guideParamMap":Ljava/util/Map;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "onChatAi--> guideSessionId: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v3, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->guideSessionId:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v3, "InspectionServiceImpl"

    invoke-static {v3, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 719
    sget-object v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->guideSessionId:Ljava/lang/String;

    const-string v4, "default"

    invoke-static {v1, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 720
    const-string/jumbo v1, "sessionId"

    sget-object v4, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->guideSessionId:Ljava/lang/String;

    invoke-interface {v0, v1, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 721
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "onChatAi--> \u4f7f\u7528guideSessionId: "

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v4, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->guideSessionId:Ljava/lang/String;

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v3, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 722
    sput-boolean v2, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->isInspect:Z

    .line 724
    :cond_0
    new-instance v1, Lcom/google/gson/Gson;

    invoke-direct {v1}, Lcom/google/gson/Gson;-><init>()V

    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 725
    .local v1, "gauideParam":Ljava/lang/String;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "onChatAi--> gauideParam "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v3, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 726
    sget-object v4, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->defaultScope:Lkotlinx/coroutines/CoroutineScope;

    new-instance v2, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$toInspect$1;

    const/4 v3, 0x0

    invoke-direct {v2, v1, v3}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$toInspect$1;-><init>(Ljava/lang/String;Lkotlin/coroutines/Continuation;)V

    move-object v7, v2

    check-cast v7, Lkotlin/jvm/functions/Function2;

    const/4 v8, 0x3

    const/4 v9, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    invoke-static/range {v4 .. v9}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 760
    return-void
.end method

.method public final toInspectEnd(Ljava/lang/String;)V
    .locals 3
    .param p1, "sessionId"    # Ljava/lang/String;

    const-string/jumbo v0, "sessionId"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 580
    const/4 v0, 0x0

    sput-boolean v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->isInspect:Z

    .line 582
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectRequest;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectRequest;

    new-instance v1, Lcom/rokid/security/phone/sdk/server/inspection/PhotoUploadRequest;

    invoke-static {}, Lkotlin/collections/CollectionsKt;->emptyList()Ljava/util/List;

    move-result-object v2

    invoke-direct {v1, p1, v2}, Lcom/rokid/security/phone/sdk/server/inspection/PhotoUploadRequest;-><init>(Ljava/lang/String;Ljava/util/List;)V

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectRequest;->uploadPhoto(Lcom/rokid/security/phone/sdk/server/inspection/PhotoUploadRequest;)V

    .line 583
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->imageUploadManager:Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;

    if-nez v0, :cond_0

    const-string v0, "imageUploadManager"

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    const/4 v0, 0x0

    :cond_0
    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/inspection/ImageUploadManager;->startUploads()V

    .line 584
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->stopGlobalRecording()V

    .line 585
    return-void
.end method

.method public final toTakePicture(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V
    .locals 2
    .param p1, "extra"    # Lcom/rokid/security/sdk/base/common/AiChatExtra;

    const-string v0, "extra"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 590
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getAnswer()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->takePictureId:Ljava/lang/String;

    .line 591
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->pendingTakePicture:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 592
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v1, "toTakePicture requested id:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->takePictureId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "InspectionServiceImpl"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 593
    return-void
.end method

.method public final uploadImgList()V
    .locals 33

    .line 165
    sget-boolean v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->isInspect:Z

    if-nez v0, :cond_14

    .line 166
    sget-object v0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->inspectionDataManager:Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;

    const-string v1, "inspectionDataManager"

    if-nez v0, :cond_0

    invoke-static {v1}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    const/4 v0, 0x0

    :cond_0
    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->readInspectionData()Ljava/util/Map;

    move-result-object v0

    .line 167
    .local v0, "imageInfoDict":Ljava/util/Map;
    invoke-interface {v0}, Ljava/util/Map;->isEmpty()Z

    move-result v3

    const-string v4, "InspectionServiceImpl"

    if-eqz v3, :cond_1

    .line 168
    const-string v3, "inspectionData is empty, no guideSessionId to check."

    invoke-static {v4, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 170
    :cond_1
    sget-object v3, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultManager;

    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultManager;->readAllResults()Ljava/util/Map;

    move-result-object v3

    .line 171
    .local v3, "offlineData":Ljava/util/Map;
    move-object v5, v0

    .local v5, "$this$forEach$iv":Ljava/util/Map;
    const/4 v6, 0x0

    .line 895
    .local v6, "$i$f$forEach":I
    invoke-interface {v5}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v7

    invoke-interface {v7}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v7

    :goto_0
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_13

    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/util/Map$Entry;

    .local v8, "element$iv":Ljava/util/Map$Entry;
    const/4 v9, 0x0

    .line 171
    .local v9, "$i$a$-forEach-InspectionServiceImpl$uploadImgList$1":I
    invoke-interface {v8}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Ljava/lang/String;

    .local v10, "guideSessionIdKey":Ljava/lang/String;
    invoke-interface {v8}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Ljava/util/Map;

    .line 172
    .local v11, "imageMap":Ljava/util/Map;
    const/4 v12, 0x0

    .local v12, "uploadList":Ljava/lang/Object;
    new-instance v13, Ljava/util/ArrayList;

    invoke-direct {v13}, Ljava/util/ArrayList;-><init>()V

    move-object v12, v13

    check-cast v12, Ljava/util/List;

    .line 173
    const/4 v13, 0x0

    .local v13, "audioMap":Ljava/lang/Object;
    invoke-interface {v3, v10}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v13

    .line 175
    move-object v14, v11

    .local v14, "$this$forEach$iv":Ljava/util/Map;
    const/4 v15, 0x0

    .line 896
    .local v15, "$i$f$forEach":I
    invoke-interface {v14}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v16

    invoke-interface/range {v16 .. v16}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v16

    :goto_1
    invoke-interface/range {v16 .. v16}, Ljava/util/Iterator;->hasNext()Z

    move-result v17

    const/16 v18, 0x1

    if-eqz v17, :cond_b

    invoke-interface/range {v16 .. v16}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v17

    check-cast v17, Ljava/util/Map$Entry;

    .local v17, "element$iv":Ljava/util/Map$Entry;
    const/16 v20, 0x0

    .line 175
    .local v20, "$i$a$-forEach-InspectionServiceImpl$uploadImgList$1$1":I
    invoke-interface/range {v17 .. v17}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v21

    move-object/from16 v2, v21

    check-cast v2, Ljava/lang/String;

    .local v2, "filepath":Ljava/lang/String;
    invoke-interface/range {v17 .. v17}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v21

    check-cast v21, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;

    .line 176
    .local v21, "imageInfo":Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;
    move-object/from16 v22, v0

    .end local v0    # "imageInfoDict":Ljava/util/Map;
    .local v22, "imageInfoDict":Ljava/util/Map;
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v23, v3

    .end local v3    # "offlineData":Ljava/util/Map;
    .local v23, "offlineData":Ljava/util/Map;
    const-string v3, "  Image: "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, ", URL: "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual/range {v21 .. v21}, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;->getUrl()Ljava/lang/String;

    move-result-object v3

    check-cast v3, Ljava/lang/CharSequence;

    invoke-interface {v3}, Ljava/lang/CharSequence;->length()I

    move-result v3

    if-lez v3, :cond_2

    move/from16 v3, v18

    goto :goto_2

    :cond_2
    const/4 v3, 0x0

    :goto_2
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v4, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 177
    invoke-virtual/range {v21 .. v21}, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;->getTaskId()Ljava/lang/String;

    move-result-object v0

    .line 178
    .local v0, "taskId":Ljava/lang/String;
    move-object v3, v13

    check-cast v3, Ljava/util/Map;

    if-eqz v3, :cond_3

    invoke-interface {v3, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultItem;

    goto :goto_3

    :cond_3
    const/4 v3, 0x0

    .line 180
    .local v3, "audioItem":Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultItem;
    :goto_3
    invoke-virtual/range {v21 .. v21}, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;->getUrl()Ljava/lang/String;

    move-result-object v24

    check-cast v24, Ljava/lang/CharSequence;

    invoke-interface/range {v24 .. v24}, Ljava/lang/CharSequence;->length()I

    move-result v24

    if-lez v24, :cond_4

    goto :goto_4

    :cond_4
    const/16 v18, 0x0

    :goto_4
    if-eqz v18, :cond_a

    .line 181
    move-object/from16 v18, v12

    check-cast v18, Ljava/lang/Iterable;

    .local v18, "$this$filter$iv":Ljava/lang/Iterable;
    const/16 v24, 0x0

    .line 897
    .local v24, "$i$f$filter":I
    new-instance v25, Ljava/util/ArrayList;

    invoke-direct/range {v25 .. v25}, Ljava/util/ArrayList;-><init>()V

    check-cast v25, Ljava/util/Collection;

    .local v25, "destination$iv$iv":Ljava/util/Collection;
    move-object/from16 v26, v18

    .local v26, "$this$filterTo$iv$iv":Ljava/lang/Iterable;
    move-object/from16 v27, v25

    .end local v25    # "destination$iv$iv":Ljava/util/Collection;
    .local v27, "destination$iv$iv":Ljava/util/Collection;
    const/16 v25, 0x0

    .line 898
    .local v25, "$i$f$filterTo":I
    invoke-interface/range {v26 .. v26}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v28

    :goto_5
    invoke-interface/range {v28 .. v28}, Ljava/util/Iterator;->hasNext()Z

    move-result v29

    if-eqz v29, :cond_6

    move-object/from16 v29, v2

    .end local v2    # "filepath":Ljava/lang/String;
    .local v29, "filepath":Ljava/lang/String;
    invoke-interface/range {v28 .. v28}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    .local v2, "element$iv$iv":Ljava/lang/Object;
    move-object/from16 v30, v2

    check-cast v30, Lcom/rokid/security/phone/sdk/server/inspection/PhotoItem;

    .local v30, "it":Lcom/rokid/security/phone/sdk/server/inspection/PhotoItem;
    const/16 v31, 0x0

    .line 181
    .local v31, "$i$a$-filter-InspectionServiceImpl$uploadImgList$1$1$tpItem$1":I
    move-object/from16 v32, v5

    .end local v5    # "$this$forEach$iv":Ljava/util/Map;
    .local v32, "$this$forEach$iv":Ljava/util/Map;
    invoke-virtual/range {v30 .. v30}, Lcom/rokid/security/phone/sdk/server/inspection/PhotoItem;->getData()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v0}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v5

    .line 898
    .end local v30    # "it":Lcom/rokid/security/phone/sdk/server/inspection/PhotoItem;
    .end local v31    # "$i$a$-filter-InspectionServiceImpl$uploadImgList$1$1$tpItem$1":I
    if-eqz v5, :cond_5

    move-object/from16 v5, v27

    .end local v27    # "destination$iv$iv":Ljava/util/Collection;
    .local v5, "destination$iv$iv":Ljava/util/Collection;
    invoke-interface {v5, v2}, Ljava/util/Collection;->add(Ljava/lang/Object;)Z

    goto :goto_6

    .end local v5    # "destination$iv$iv":Ljava/util/Collection;
    .restart local v27    # "destination$iv$iv":Ljava/util/Collection;
    :cond_5
    move-object/from16 v5, v27

    .end local v27    # "destination$iv$iv":Ljava/util/Collection;
    .restart local v5    # "destination$iv$iv":Ljava/util/Collection;
    :goto_6
    move-object/from16 v2, v29

    move-object/from16 v5, v32

    goto :goto_5

    .line 899
    .end local v29    # "filepath":Ljava/lang/String;
    .end local v32    # "$this$forEach$iv":Ljava/util/Map;
    .local v2, "filepath":Ljava/lang/String;
    .local v5, "$this$forEach$iv":Ljava/util/Map;
    .restart local v27    # "destination$iv$iv":Ljava/util/Collection;
    :cond_6
    move-object/from16 v29, v2

    move-object/from16 v32, v5

    move-object/from16 v5, v27

    .end local v2    # "filepath":Ljava/lang/String;
    .end local v5    # "$this$forEach$iv":Ljava/util/Map;
    .end local v25    # "$i$f$filterTo":I
    .end local v26    # "$this$filterTo$iv$iv":Ljava/lang/Iterable;
    .end local v27    # "destination$iv$iv":Ljava/util/Collection;
    .restart local v29    # "filepath":Ljava/lang/String;
    .restart local v32    # "$this$forEach$iv":Ljava/util/Map;
    move-object v2, v5

    check-cast v2, Ljava/util/List;

    .line 897
    nop

    .line 181
    .end local v18    # "$this$filter$iv":Ljava/lang/Iterable;
    .end local v24    # "$i$f$filter":I
    nop

    .line 182
    .local v2, "tpItem":Ljava/util/List;
    invoke-virtual/range {v21 .. v21}, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;->getUrl()Ljava/lang/String;

    move-result-object v5

    .line 183
    .local v5, "url":Ljava/lang/String;
    const-string v18, ""

    .line 184
    .local v18, "audioUrl":Ljava/lang/String;
    move/from16 v24, v6

    .end local v6    # "$i$f$forEach":I
    .local v24, "$i$f$forEach":I
    invoke-virtual/range {v21 .. v21}, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;->getFileId()Ljava/lang/String;

    move-result-object v6

    .line 186
    .local v6, "fileId":Ljava/lang/String;
    move-object/from16 v25, v7

    const-string v7, "aac"

    move-object/from16 v26, v8

    .end local v8    # "element$iv":Ljava/util/Map$Entry;
    .local v26, "element$iv":Ljava/util/Map$Entry;
    const/4 v8, 0x2

    move/from16 v27, v9

    move-object/from16 v19, v13

    const/4 v9, 0x0

    const/4 v13, 0x0

    .end local v9    # "$i$a$-forEach-InspectionServiceImpl$uploadImgList$1":I
    .end local v13    # "audioMap":Ljava/lang/Object;
    .local v19, "audioMap":Ljava/lang/Object;
    .local v27, "$i$a$-forEach-InspectionServiceImpl$uploadImgList$1":I
    invoke-static {v5, v7, v13, v8, v9}, Lkotlin/text/StringsKt;->endsWith$default(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_7

    .line 187
    move-object/from16 v18, v5

    move-object/from16 v7, v18

    goto :goto_7

    .line 186
    :cond_7
    move-object/from16 v7, v18

    .line 189
    .end local v18    # "audioUrl":Ljava/lang/String;
    .local v7, "audioUrl":Ljava/lang/String;
    :goto_7
    move-object v8, v2

    check-cast v8, Ljava/util/Collection;

    invoke-interface {v8}, Ljava/util/Collection;->size()I

    move-result v8

    if-nez v8, :cond_8

    .line 190
    move-object v8, v12

    check-cast v8, Ljava/util/Collection;

    new-instance v13, Lcom/rokid/security/phone/sdk/server/inspection/PhotoItem;

    .line 191
    nop

    .line 192
    nop

    .line 193
    nop

    .line 194
    invoke-virtual/range {v21 .. v21}, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;->getTime()J

    move-result-wide v30

    invoke-static/range {v30 .. v31}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v9

    .line 190
    invoke-direct {v13, v6, v0, v7, v9}, Lcom/rokid/security/phone/sdk/server/inspection/PhotoItem;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Long;)V

    invoke-interface {v8, v13}, Ljava/util/Collection;->add(Ljava/lang/Object;)Z

    goto :goto_9

    .line 197
    :cond_8
    const/4 v13, 0x0

    invoke-interface {v2, v13}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Lcom/rokid/security/phone/sdk/server/inspection/PhotoItem;

    invoke-virtual {v8, v7}, Lcom/rokid/security/phone/sdk/server/inspection/PhotoItem;->setAudioUrl(Ljava/lang/String;)V

    .line 198
    invoke-interface {v2, v13}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Lcom/rokid/security/phone/sdk/server/inspection/PhotoItem;

    invoke-virtual {v8, v6}, Lcom/rokid/security/phone/sdk/server/inspection/PhotoItem;->setFileId(Ljava/lang/String;)V

    .line 200
    invoke-interface {v2, v13}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Lcom/rokid/security/phone/sdk/server/inspection/PhotoItem;

    if-eqz v3, :cond_9

    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultItem;->getTimestamp()J

    move-result-wide v30

    invoke-static/range {v30 .. v31}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v9

    goto :goto_8

    :cond_9
    const/4 v9, 0x0

    :goto_8
    invoke-virtual {v8, v9}, Lcom/rokid/security/phone/sdk/server/inspection/PhotoItem;->setTime(Ljava/lang/Long;)V

    goto :goto_9

    .line 180
    .end local v7    # "audioUrl":Ljava/lang/String;
    .end local v19    # "audioMap":Ljava/lang/Object;
    .end local v24    # "$i$f$forEach":I
    .end local v26    # "element$iv":Ljava/util/Map$Entry;
    .end local v27    # "$i$a$-forEach-InspectionServiceImpl$uploadImgList$1":I
    .end local v29    # "filepath":Ljava/lang/String;
    .end local v32    # "$this$forEach$iv":Ljava/util/Map;
    .local v2, "filepath":Ljava/lang/String;
    .local v5, "$this$forEach$iv":Ljava/util/Map;
    .local v6, "$i$f$forEach":I
    .restart local v8    # "element$iv":Ljava/util/Map$Entry;
    .restart local v9    # "$i$a$-forEach-InspectionServiceImpl$uploadImgList$1":I
    .restart local v13    # "audioMap":Ljava/lang/Object;
    :cond_a
    move-object/from16 v29, v2

    move-object/from16 v32, v5

    move/from16 v24, v6

    move-object/from16 v25, v7

    move-object/from16 v26, v8

    move/from16 v27, v9

    move-object/from16 v19, v13

    .line 203
    .end local v2    # "filepath":Ljava/lang/String;
    .end local v5    # "$this$forEach$iv":Ljava/util/Map;
    .end local v6    # "$i$f$forEach":I
    .end local v8    # "element$iv":Ljava/util/Map$Entry;
    .end local v9    # "$i$a$-forEach-InspectionServiceImpl$uploadImgList$1":I
    .end local v13    # "audioMap":Ljava/lang/Object;
    .restart local v19    # "audioMap":Ljava/lang/Object;
    .restart local v24    # "$i$f$forEach":I
    .restart local v26    # "element$iv":Ljava/util/Map$Entry;
    .restart local v27    # "$i$a$-forEach-InspectionServiceImpl$uploadImgList$1":I
    .restart local v29    # "filepath":Ljava/lang/String;
    .restart local v32    # "$this$forEach$iv":Ljava/util/Map;
    :goto_9
    nop

    .line 896
    .end local v0    # "taskId":Ljava/lang/String;
    .end local v3    # "audioItem":Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineResultItem;
    .end local v20    # "$i$a$-forEach-InspectionServiceImpl$uploadImgList$1$1":I
    .end local v21    # "imageInfo":Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;
    .end local v29    # "filepath":Ljava/lang/String;
    move-object/from16 v13, v19

    move-object/from16 v0, v22

    move-object/from16 v3, v23

    move/from16 v6, v24

    move-object/from16 v7, v25

    move-object/from16 v8, v26

    move/from16 v9, v27

    move-object/from16 v5, v32

    .end local v17    # "element$iv":Ljava/util/Map$Entry;
    goto/16 :goto_1

    .line 900
    .end local v19    # "audioMap":Ljava/lang/Object;
    .end local v22    # "imageInfoDict":Ljava/util/Map;
    .end local v23    # "offlineData":Ljava/util/Map;
    .end local v24    # "$i$f$forEach":I
    .end local v26    # "element$iv":Ljava/util/Map$Entry;
    .end local v27    # "$i$a$-forEach-InspectionServiceImpl$uploadImgList$1":I
    .end local v32    # "$this$forEach$iv":Ljava/util/Map;
    .local v0, "imageInfoDict":Ljava/util/Map;
    .local v3, "offlineData":Ljava/util/Map;
    .restart local v5    # "$this$forEach$iv":Ljava/util/Map;
    .restart local v6    # "$i$f$forEach":I
    .restart local v8    # "element$iv":Ljava/util/Map$Entry;
    .restart local v9    # "$i$a$-forEach-InspectionServiceImpl$uploadImgList$1":I
    .restart local v13    # "audioMap":Ljava/lang/Object;
    :cond_b
    move-object/from16 v22, v0

    move-object/from16 v23, v3

    move-object/from16 v32, v5

    move/from16 v24, v6

    move-object/from16 v25, v7

    move-object/from16 v26, v8

    move/from16 v27, v9

    move-object/from16 v19, v13

    const/4 v13, 0x0

    .line 204
    .end local v0    # "imageInfoDict":Ljava/util/Map;
    .end local v3    # "offlineData":Ljava/util/Map;
    .end local v5    # "$this$forEach$iv":Ljava/util/Map;
    .end local v6    # "$i$f$forEach":I
    .end local v8    # "element$iv":Ljava/util/Map$Entry;
    .end local v9    # "$i$a$-forEach-InspectionServiceImpl$uploadImgList$1":I
    .end local v13    # "audioMap":Ljava/lang/Object;
    .end local v14    # "$this$forEach$iv":Ljava/util/Map;
    .end local v15    # "$i$f$forEach":I
    .restart local v19    # "audioMap":Ljava/lang/Object;
    .restart local v22    # "imageInfoDict":Ljava/util/Map;
    .restart local v23    # "offlineData":Ljava/util/Map;
    .restart local v24    # "$i$f$forEach":I
    .restart local v26    # "element$iv":Ljava/util/Map$Entry;
    .restart local v27    # "$i$a$-forEach-InspectionServiceImpl$uploadImgList$1":I
    .restart local v32    # "$this$forEach$iv":Ljava/util/Map;
    invoke-interface {v11}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$all$iv":Ljava/lang/Iterable;
    const/4 v2, 0x0

    .line 901
    .local v2, "$i$f$all":I
    instance-of v3, v0, Ljava/util/Collection;

    if-eqz v3, :cond_c

    move-object v3, v0

    check-cast v3, Ljava/util/Collection;

    invoke-interface {v3}, Ljava/util/Collection;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_c

    goto :goto_b

    .line 902
    :cond_c
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_d
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_f

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    .local v5, "element$iv":Ljava/lang/Object;
    move-object v6, v5

    check-cast v6, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;

    .local v6, "it":Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;
    const/4 v7, 0x0

    .line 204
    .local v7, "$i$a$-all-InspectionServiceImpl$uploadImgList$1$allImagesHaveUrl$1":I
    invoke-virtual {v6}, Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;->getUrl()Ljava/lang/String;

    move-result-object v8

    check-cast v8, Ljava/lang/CharSequence;

    invoke-interface {v8}, Ljava/lang/CharSequence;->length()I

    move-result v8

    if-lez v8, :cond_e

    move/from16 v8, v18

    goto :goto_a

    :cond_e
    move v8, v13

    .line 902
    .end local v6    # "it":Lcom/rokid/security/phone/sdk/server/inspection/InspectDataInfo;
    .end local v7    # "$i$a$-all-InspectionServiceImpl$uploadImgList$1$allImagesHaveUrl$1":I
    :goto_a
    if-nez v8, :cond_d

    move/from16 v18, v13

    goto :goto_b

    .line 903
    .end local v5    # "element$iv":Ljava/lang/Object;
    :cond_f
    nop

    .line 204
    .end local v0    # "$this$all$iv":Ljava/lang/Iterable;
    .end local v2    # "$i$f$all":I
    :goto_b
    move/from16 v0, v18

    .line 205
    .local v0, "allImagesHaveUrl":Z
    if-eqz v0, :cond_12

    .line 206
    new-instance v2, Lcom/rokid/security/phone/sdk/server/inspection/PhotoUploadRequest;

    invoke-direct {v2, v10, v12}, Lcom/rokid/security/phone/sdk/server/inspection/PhotoUploadRequest;-><init>(Ljava/lang/String;Ljava/util/List;)V

    .line 207
    .local v2, "pr":Lcom/rokid/security/phone/sdk/server/inspection/PhotoUploadRequest;
    sget-object v3, Lcom/rokid/security/phone/sdk/server/inspection/InspectRequest;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectRequest;

    invoke-virtual {v3, v2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectRequest;->uploadPhoto(Lcom/rokid/security/phone/sdk/server/inspection/PhotoUploadRequest;)V

    .line 208
    new-instance v3, Ljava/io/File;

    sget-object v5, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->inspectionDir:Ljava/io/File;

    invoke-static {v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-direct {v3, v5, v10}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 209
    .local v3, "tpimgDir":Ljava/io/File;
    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v5

    if-eqz v5, :cond_10

    .line 210
    invoke-virtual {v3}, Ljava/io/File;->delete()Z

    move-result v5

    .line 211
    .local v5, "deleted":Z
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v7, "\ud83d\uddd1 File deleted: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v3}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, ", success="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v4, v6}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 213
    .end local v5    # "deleted":Z
    :cond_10
    sget-object v5, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;->inspectionDataManager:Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;

    if-nez v5, :cond_11

    invoke-static {v1}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    const/4 v5, 0x0

    :cond_11
    invoke-virtual {v5, v10}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionDataManager;->removeSubfolderName(Ljava/lang/String;)V

    .line 214
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "All images in guideSessionId "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " have URLs."

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 216
    .end local v2    # "pr":Lcom/rokid/security/phone/sdk/server/inspection/PhotoUploadRequest;
    .end local v3    # "tpimgDir":Ljava/io/File;
    :cond_12
    nop

    .line 895
    .end local v0    # "allImagesHaveUrl":Z
    .end local v10    # "guideSessionIdKey":Ljava/lang/String;
    .end local v11    # "imageMap":Ljava/util/Map;
    .end local v12    # "uploadList":Ljava/lang/Object;
    .end local v19    # "audioMap":Ljava/lang/Object;
    .end local v27    # "$i$a$-forEach-InspectionServiceImpl$uploadImgList$1":I
    move-object/from16 v0, v22

    move-object/from16 v3, v23

    move/from16 v6, v24

    move-object/from16 v7, v25

    move-object/from16 v5, v32

    .end local v26    # "element$iv":Ljava/util/Map$Entry;
    goto/16 :goto_0

    .line 904
    .end local v22    # "imageInfoDict":Ljava/util/Map;
    .end local v23    # "offlineData":Ljava/util/Map;
    .end local v24    # "$i$f$forEach":I
    .end local v32    # "$this$forEach$iv":Ljava/util/Map;
    .local v0, "imageInfoDict":Ljava/util/Map;
    .local v3, "offlineData":Ljava/util/Map;
    .local v5, "$this$forEach$iv":Ljava/util/Map;
    .local v6, "$i$f$forEach":I
    :cond_13
    move-object/from16 v22, v0

    move-object/from16 v23, v3

    move-object/from16 v32, v5

    move/from16 v24, v6

    .line 218
    .end local v0    # "imageInfoDict":Ljava/util/Map;
    .end local v3    # "offlineData":Ljava/util/Map;
    .end local v5    # "$this$forEach$iv":Ljava/util/Map;
    .end local v6    # "$i$f$forEach":I
    :cond_14
    return-void
.end method
