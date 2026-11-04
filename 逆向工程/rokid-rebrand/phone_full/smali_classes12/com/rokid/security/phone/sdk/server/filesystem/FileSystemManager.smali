.class public final Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;
.super Lcom/rokid/security/phone/sdk/api/filesystem/api/AbsFileSystemService;
.source "FileSystemManager.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nFileSystemManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 FileSystemManager.kt\ncom/rokid/security/phone/sdk/server/filesystem/FileSystemManager\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,431:1\n1855#2,2:432\n1855#2,2:434\n1855#2,2:436\n1855#2,2:438\n*S KotlinDebug\n*F\n+ 1 FileSystemManager.kt\ncom/rokid/security/phone/sdk/server/filesystem/FileSystemManager\n*L\n229#1:432,2\n249#1:434,2\n269#1:436,2\n286#1:438,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000k\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0007\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0008\u0003\n\u0002\u0010\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u000b\n\u0002\u0008\u0006\n\u0002\u0010\t\n\u0002\u0008\u0013*\u0001\u0017\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0010\u0010\u0019\u001a\u00020\u001a2\u0006\u0010\u001b\u001a\u00020\u0013H\u0016J\u000e\u0010\u001c\u001a\u00020\u001d2\u0006\u0010\u001e\u001a\u00020\u0004J\u000e\u0010\u001f\u001a\u00020\u001d2\u0006\u0010\u001e\u001a\u00020\u0004J\u000e\u0010 \u001a\u00020\u00042\u0006\u0010!\u001a\u00020\"J\u000e\u0010#\u001a\u00020\u001d2\u0006\u0010\u001e\u001a\u00020\u0004J\u0006\u0010$\u001a\u00020\u001aJ\u0008\u0010%\u001a\u00020&H\u0002J\u0006\u0010\'\u001a\u00020&J\u000e\u0010(\u001a\u00020&2\u0006\u0010\u001e\u001a\u00020\u0004J&\u0010)\u001a\u00020\u001a2\u0006\u0010\u001e\u001a\u00020\u00042\u0006\u0010*\u001a\u00020\u00042\u0006\u0010+\u001a\u00020\u00042\u0006\u0010,\u001a\u00020-J*\u0010.\u001a\u00020\u001a2\u0006\u0010/\u001a\u00020\u00042\u0006\u00100\u001a\u00020\u00042\u0008\u00101\u001a\u0004\u0018\u00010\u00042\u0006\u0010\u001e\u001a\u00020\u0004H\u0002J\"\u00102\u001a\u00020\u001a2\u0006\u00103\u001a\u00020\u00042\u0008\u00101\u001a\u0004\u0018\u00010\u00042\u0006\u0010\u001e\u001a\u00020\u0004H\u0002J\u000e\u00104\u001a\u00020\u001a2\u0006\u00105\u001a\u00020\u0004J\u0010\u00106\u001a\u00020\u001a2\u0006\u00107\u001a\u00020\u001dH\u0002J\"\u00108\u001a\u00020\u001a2\u0006\u0010\u001e\u001a\u00020\u00042\u0006\u00109\u001a\u00020\u00042\u0008\u00101\u001a\u0004\u0018\u00010\u0004H\u0002J&\u0010:\u001a\u00020\u001a2\u0006\u0010\u001e\u001a\u00020\u00042\u0006\u0010*\u001a\u00020\u00042\u0006\u0010+\u001a\u00020\u00042\u0006\u0010,\u001a\u00020-J\u0008\u0010;\u001a\u00020\u001aH\u0016J\u000e\u0010;\u001a\u00020\u001a2\u0006\u0010\u001b\u001a\u00020\u0013J\u0010\u0010<\u001a\u00020\u001a2\u0006\u0010\u001b\u001a\u00020\u0013H\u0016J\u0016\u0010=\u001a\u00020&2\u0006\u0010\u001e\u001a\u00020\u00042\u0006\u0010>\u001a\u00020-J\u0006\u0010?\u001a\u00020&R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u001a\u0010\u0006\u001a\u000e\u0012\u0004\u0012\u00020\u0004\u0012\u0004\u0012\u00020\u00080\u0007X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\t\u001a\u00020\nX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u001b\u0010\u000b\u001a\u00020\u000c8BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\u000f\u0010\u0010\u001a\u0004\u0008\r\u0010\u000eR\u0014\u0010\u0011\u001a\u0008\u0012\u0004\u0012\u00020\u00130\u0012X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0014\u001a\u00020\u0015X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0016\u001a\u00020\u0017X\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u0018\u00a8\u0006@"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;",
        "Lcom/rokid/security/phone/sdk/api/filesystem/api/AbsFileSystemService;",
        "()V",
        "AUTH_PENDING_ERROR",
        "",
        "TAG",
        "fileReferenceCount",
        "Ljava/util/concurrent/ConcurrentHashMap;",
        "Ljava/util/concurrent/atomic/AtomicInteger;",
        "lastProgress",
        "",
        "mFileSystemRepository",
        "Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;",
        "getMFileSystemRepository",
        "()Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;",
        "mFileSystemRepository$delegate",
        "Lkotlin/Lazy;",
        "mFileUploadListeners",
        "Ljava/util/concurrent/CopyOnWriteArrayList;",
        "Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;",
        "mGson",
        "Lcom/google/gson/Gson;",
        "mInterMessageListener",
        "com/rokid/security/phone/sdk/server/filesystem/FileSystemManager$mInterMessageListener$1",
        "Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$mInterMessageListener$1;",
        "addFileUploadListener",
        "",
        "listener",
        "decrementFileReference",
        "",
        "filePath",
        "getFileReferenceCount",
        "getMimeType",
        "file",
        "Ljava/io/File;",
        "incrementFileReference",
        "initFileSystem",
        "isCloudUploadAuthReady",
        "",
        "isCloudUploadReady",
        "isFileSafeToDelete",
        "minioFileUpload",
        "tag",
        "category",
        "captureTime",
        "",
        "onComplete",
        "fileId",
        "fileUrl",
        "fileMd5",
        "onErrorListener",
        "errorMsg",
        "onMessage",
        "msg",
        "onProgressChanged",
        "percent",
        "onStart",
        "fileName",
        "ossFileUpload",
        "removeFileUploadListener",
        "setFileUploadListener",
        "updateFileLastModified",
        "targetTime",
        "useMinio",
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
.field private static final AUTH_PENDING_ERROR:Ljava/lang/String; = "auth_pending:\u624b\u673a\u7aef\u767b\u5f55\u6001\u672a\u5c31\u7eea\uff0c\u7b49\u5f85 token \u5237\u65b0"

.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;

.field private static final TAG:Ljava/lang/String;

.field private static final fileReferenceCount:Ljava/util/concurrent/ConcurrentHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ConcurrentHashMap<",
            "Ljava/lang/String;",
            "Ljava/util/concurrent/atomic/AtomicInteger;",
            ">;"
        }
    .end annotation
.end field

.field private static lastProgress:F

.field private static final mFileSystemRepository$delegate:Lkotlin/Lazy;

.field private static final mFileUploadListeners:Ljava/util/concurrent/CopyOnWriteArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/CopyOnWriteArrayList<",
            "Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;",
            ">;"
        }
    .end annotation
.end field

.field private static mGson:Lcom/google/gson/Gson;

.field private static final mInterMessageListener:Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$mInterMessageListener$1;


# direct methods
.method public static synthetic $r8$lambda$Wm0wk1Kgh05xJ2lGw9gnsCE23w0(Lkotlin/jvm/functions/Function1;Ljava/lang/Object;)Ljava/util/concurrent/atomic/AtomicInteger;
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->incrementFileReference$lambda$0(Lkotlin/jvm/functions/Function1;Ljava/lang/Object;)Ljava/util/concurrent/atomic/AtomicInteger;

    move-result-object p0

    return-object p0
.end method

.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;

    .line 52
    const-string v0, "FileSystemManager::"

    sput-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->TAG:Ljava/lang/String;

    .line 54
    sget-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$mFileSystemRepository$2;->INSTANCE:Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$mFileSystemRepository$2;

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->mFileSystemRepository$delegate:Lkotlin/Lazy;

    .line 57
    new-instance v0, Lcom/google/gson/Gson;

    invoke-direct {v0}, Lcom/google/gson/Gson;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->mGson:Lcom/google/gson/Gson;

    .line 59
    new-instance v0, Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-direct {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->mFileUploadListeners:Ljava/util/concurrent/CopyOnWriteArrayList;

    .line 62
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->fileReferenceCount:Ljava/util/concurrent/ConcurrentHashMap;

    .line 114
    new-instance v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$mInterMessageListener$1;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$mInterMessageListener$1;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$mInterMessageListener$1;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 50
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/api/filesystem/api/AbsFileSystemService;-><init>()V

    return-void
.end method

.method public static final synthetic access$getTAG$p()Ljava/lang/String;
    .locals 1

    .line 50
    sget-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$onComplete(Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;
    .param p1, "fileId"    # Ljava/lang/String;
    .param p2, "fileUrl"    # Ljava/lang/String;
    .param p3, "fileMd5"    # Ljava/lang/String;
    .param p4, "filePath"    # Ljava/lang/String;

    .line 50
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->onComplete(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static final synthetic access$onErrorListener(Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;
    .param p1, "errorMsg"    # Ljava/lang/String;
    .param p2, "fileMd5"    # Ljava/lang/String;
    .param p3, "filePath"    # Ljava/lang/String;

    .line 50
    invoke-direct {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->onErrorListener(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static final synthetic access$onProgressChanged(Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;I)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;
    .param p1, "percent"    # I

    .line 50
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->onProgressChanged(I)V

    return-void
.end method

.method public static final synthetic access$onStart(Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;
    .param p1, "filePath"    # Ljava/lang/String;
    .param p2, "fileName"    # Ljava/lang/String;
    .param p3, "fileMd5"    # Ljava/lang/String;

    .line 50
    invoke-direct {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->onStart(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method private final getMFileSystemRepository()Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;
    .locals 1

    .line 54
    sget-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->mFileSystemRepository$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    return-object v0
.end method

.method private static final incrementFileReference$lambda$0(Lkotlin/jvm/functions/Function1;Ljava/lang/Object;)Ljava/util/concurrent/atomic/AtomicInteger;
    .locals 1
    .param p0, "$tmp0"    # Lkotlin/jvm/functions/Function1;
    .param p1, "p0"    # Ljava/lang/Object;

    const-string v0, "$tmp0"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 69
    invoke-interface {p0, p1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/concurrent/atomic/AtomicInteger;

    return-object v0
.end method

.method private final isCloudUploadAuthReady()Z
    .locals 7

    .line 195
    sget-object v0, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->ensureBusinessHeaders()V

    .line 196
    sget-object v0, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getHeaders()Ljava/util/concurrent/ConcurrentHashMap;

    move-result-object v0

    const-string/jumbo v1, "x-user-authorization"

    invoke-virtual {v0, v1}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eqz v0, :cond_1

    invoke-static {v0}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    move v0, v1

    goto :goto_1

    :cond_1
    :goto_0
    move v0, v2

    :goto_1
    xor-int/2addr v0, v2

    .line 197
    .local v0, "hasUserAuth":Z
    sget-object v3, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v3}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getHeaders()Ljava/util/concurrent/ConcurrentHashMap;

    move-result-object v3

    const-string v4, "X-Agent"

    invoke-virtual {v3, v4}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/CharSequence;

    if-eqz v3, :cond_3

    invoke-static {v3}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_2

    goto :goto_2

    :cond_2
    move v3, v1

    goto :goto_3

    :cond_3
    :goto_2
    move v3, v2

    :goto_3
    xor-int/2addr v3, v2

    .line 198
    .local v3, "hasAgent":Z
    sget-object v4, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v4}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->hasCurrentAppAuthorization()Z

    move-result v4

    .line 199
    .local v4, "hasAppAuth":Z
    if-eqz v0, :cond_5

    if-eqz v3, :cond_5

    if-nez v4, :cond_4

    goto :goto_4

    .line 203
    :cond_4
    return v2

    .line 200
    :cond_5
    :goto_4
    sget-object v2, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "cloud upload auth missing user="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " app="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " agent="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v2, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 201
    return v1
.end method

.method private final onComplete(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 19
    .param p1, "fileId"    # Ljava/lang/String;
    .param p2, "fileUrl"    # Ljava/lang/String;
    .param p3, "fileMd5"    # Ljava/lang/String;
    .param p4, "filePath"    # Ljava/lang/String;

    .line 257
    move-object/from16 v6, p1

    move-object/from16 v7, p2

    move-object/from16 v8, p3

    sget-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onComplete:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " fileUrl:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " fileMd5:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "filePath +"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move-object/from16 v9, p4

    invoke-virtual {v1, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 259
    new-instance v0, Lcom/rokid/security/sdk/base/common/FileSystemExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/FileSystemExtra;-><init>()V

    move-object v10, v0

    .line 260
    .local v10, "extra":Lcom/rokid/security/sdk/base/common/FileSystemExtra;
    const-string v0, "onComplete"

    invoke-virtual {v10, v0}, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->setMethodName(Ljava/lang/String;)V

    .line 261
    invoke-virtual {v10, v6}, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->setFileId(Ljava/lang/String;)V

    .line 262
    if-nez v8, :cond_0

    const-string v0, ""

    goto :goto_0

    :cond_0
    move-object v0, v8

    :goto_0
    invoke-virtual {v10, v0}, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->setFileMd5(Ljava/lang/String;)V

    .line 263
    invoke-virtual {v10, v7}, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->setFileUrl(Ljava/lang/String;)V

    .line 264
    sget-object v11, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    .line 265
    nop

    .line 266
    sget-object v0, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v0

    invoke-virtual {v0, v10}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v13

    const-string v0, "SenderHandler.mGson.toJson(extra)"

    invoke-static {v13, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 264
    const/16 v17, 0x1c

    const/16 v18, 0x0

    const-string v12, "FILE_SYSTEM_ACTION"

    const/4 v14, 0x0

    const/4 v15, 0x0

    const/16 v16, 0x0

    invoke-static/range {v11 .. v18}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 269
    sget-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->mFileUploadListeners:Ljava/util/concurrent/CopyOnWriteArrayList;

    move-object v11, v0

    check-cast v11, Ljava/lang/Iterable;

    .local v11, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v12, 0x0

    .line 436
    .local v12, "$i$f$forEach":I
    invoke-interface {v11}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v13

    :goto_1
    invoke-interface {v13}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {v13}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v14

    .local v14, "element$iv":Ljava/lang/Object;
    move-object v15, v14

    check-cast v15, Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;

    .local v15, "it":Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;
    const/16 v16, 0x0

    .line 270
    .local v16, "$i$a$-forEach-FileSystemManager$onComplete$1":I
    const/4 v1, 0x1

    invoke-static/range {p3 .. p3}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    move-object v0, v15

    move-object/from16 v2, p2

    move-object/from16 v4, p4

    move-object/from16 v5, p1

    invoke-interface/range {v0 .. v5}, Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;->onStatusUpdate(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 271
    nop

    .line 436
    .end local v15    # "it":Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;
    .end local v16    # "$i$a$-forEach-FileSystemManager$onComplete$1":I
    nop

    .end local v14    # "element$iv":Ljava/lang/Object;
    goto :goto_1

    .line 437
    :cond_1
    nop

    .line 272
    .end local v11    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v12    # "$i$f$forEach":I
    return-void
.end method

.method private final onErrorListener(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 15
    .param p1, "errorMsg"    # Ljava/lang/String;
    .param p2, "fileMd5"    # Ljava/lang/String;
    .param p3, "filePath"    # Ljava/lang/String;

    .line 238
    move-object/from16 v0, p1

    sget-object v1, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "onErrorListener:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 239
    new-instance v1, Lcom/rokid/security/sdk/base/common/FileSystemExtra;

    invoke-direct {v1}, Lcom/rokid/security/sdk/base/common/FileSystemExtra;-><init>()V

    .line 240
    .local v1, "extra":Lcom/rokid/security/sdk/base/common/FileSystemExtra;
    const-string v2, "onFail"

    invoke-virtual {v1, v2}, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->setMethodName(Ljava/lang/String;)V

    .line 241
    invoke-virtual {v1, v0}, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->setErrorMsg(Ljava/lang/String;)V

    .line 242
    move-object/from16 v2, p3

    invoke-virtual {v1, v2}, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->setFilePath(Ljava/lang/String;)V

    .line 243
    move-object/from16 v3, p2

    check-cast v3, Ljava/lang/CharSequence;

    if-eqz v3, :cond_1

    invoke-static {v3}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_0

    goto :goto_0

    :cond_0
    const/4 v3, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v3, 0x1

    :goto_1
    if-eqz v3, :cond_2

    move-object v3, v0

    goto :goto_2

    :cond_2
    move-object/from16 v3, p2

    :goto_2
    invoke-virtual {v1, v3}, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->setFileMd5(Ljava/lang/String;)V

    .line 244
    sget-object v4, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    .line 245
    nop

    .line 246
    sget-object v3, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v3

    invoke-virtual {v3, v1}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    const-string v3, "SenderHandler.mGson.toJson(extra)"

    invoke-static {v6, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 244
    const/16 v10, 0x1c

    const/4 v11, 0x0

    const-string v5, "FILE_SYSTEM_ACTION"

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    invoke-static/range {v4 .. v11}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 249
    sget-object v3, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->mFileUploadListeners:Ljava/util/concurrent/CopyOnWriteArrayList;

    move-object v9, v3

    check-cast v9, Ljava/lang/Iterable;

    .local v9, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v10, 0x0

    .line 434
    .local v10, "$i$f$forEach":I
    invoke-interface {v9}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v11

    :goto_3
    invoke-interface {v11}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_3

    invoke-interface {v11}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v12

    .local v12, "element$iv":Ljava/lang/Object;
    move-object v13, v12

    check-cast v13, Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;

    .local v13, "it":Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;
    const/4 v14, 0x0

    .line 250
    .local v14, "$i$a$-forEach-FileSystemManager$onErrorListener$1":I
    invoke-static/range {p2 .. p2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    const-string v8, ""

    const/4 v4, -0x1

    const-string v5, ""

    move-object v3, v13

    move-object/from16 v7, p3

    invoke-interface/range {v3 .. v8}, Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;->onStatusUpdate(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 251
    nop

    .line 434
    .end local v13    # "it":Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;
    .end local v14    # "$i$a$-forEach-FileSystemManager$onErrorListener$1":I
    nop

    .end local v12    # "element$iv":Ljava/lang/Object;
    goto :goto_3

    .line 435
    :cond_3
    nop

    .line 252
    .end local v9    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v10    # "$i$f$forEach":I
    return-void
.end method

.method private final onProgressChanged(I)V
    .locals 10
    .param p1, "percent"    # I

    .line 216
    sget-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onProgressChanged:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 217
    sget v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->lastProgress:F

    int-to-float v1, p1

    cmpg-float v0, v0, v1

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    if-nez v0, :cond_2

    .line 219
    new-instance v0, Lcom/rokid/security/sdk/base/common/FileSystemExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/FileSystemExtra;-><init>()V

    .line 220
    .local v0, "extra":Lcom/rokid/security/sdk/base/common/FileSystemExtra;
    const-string v1, "onProgressChanged"

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->setMethodName(Ljava/lang/String;)V

    .line 221
    int-to-float v1, p1

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->setProgress(F)V

    .line 222
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    .line 223
    nop

    .line 224
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    const-string v1, "SenderHandler.mGson.toJson(extra)"

    invoke-static {v4, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 222
    const/16 v8, 0x1c

    const/4 v9, 0x0

    const-string v3, "FILE_SYSTEM_ACTION"

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    invoke-static/range {v2 .. v9}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 227
    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->getProgress()F

    move-result v1

    sput v1, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->lastProgress:F

    .line 229
    sget-object v1, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->mFileUploadListeners:Ljava/util/concurrent/CopyOnWriteArrayList;

    check-cast v1, Ljava/lang/Iterable;

    .local v1, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v2, 0x0

    .line 432
    .local v2, "$i$f$forEach":I
    invoke-interface {v1}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_1

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    .local v4, "element$iv":Ljava/lang/Object;
    move-object v5, v4

    check-cast v5, Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;

    .local v5, "it":Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;
    const/4 v6, 0x0

    .line 229
    .local v6, "$i$a$-forEach-FileSystemManager$onProgressChanged$1":I
    sget v7, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->lastProgress:F

    invoke-interface {v5, v7}, Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;->onProgress(F)V

    .line 432
    .end local v5    # "it":Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;
    .end local v6    # "$i$a$-forEach-FileSystemManager$onProgressChanged$1":I
    nop

    .end local v4    # "element$iv":Ljava/lang/Object;
    goto :goto_1

    .line 433
    :cond_1
    nop

    .line 233
    .end local v0    # "extra":Lcom/rokid/security/sdk/base/common/FileSystemExtra;
    .end local v1    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v2    # "$i$f$forEach":I
    :cond_2
    return-void
.end method

.method private final onStart(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 10
    .param p1, "filePath"    # Ljava/lang/String;
    .param p2, "fileName"    # Ljava/lang/String;
    .param p3, "fileMd5"    # Ljava/lang/String;

    .line 276
    sget-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onStart:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 277
    new-instance v0, Lcom/rokid/security/sdk/base/common/FileSystemExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/FileSystemExtra;-><init>()V

    .line 278
    .local v0, "extra":Lcom/rokid/security/sdk/base/common/FileSystemExtra;
    const-string v1, "onStart"

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->setMethodName(Ljava/lang/String;)V

    .line 279
    invoke-virtual {v0, p1}, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->setFilePath(Ljava/lang/String;)V

    .line 280
    if-nez p3, :cond_0

    const-string v1, ""

    goto :goto_0

    :cond_0
    move-object v1, p3

    :goto_0
    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->setFileMd5(Ljava/lang/String;)V

    .line 281
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    .line 282
    nop

    .line 283
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    const-string v1, "SenderHandler.mGson.toJson(extra)"

    invoke-static {v4, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 281
    const/16 v8, 0x1c

    const/4 v9, 0x0

    const-string v3, "FILE_SYSTEM_ACTION"

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    invoke-static/range {v2 .. v9}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 286
    sget-object v1, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->mFileUploadListeners:Ljava/util/concurrent/CopyOnWriteArrayList;

    check-cast v1, Ljava/lang/Iterable;

    .local v1, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v2, 0x0

    .line 438
    .local v2, "$i$f$forEach":I
    invoke-interface {v1}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_1

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    .local v4, "element$iv":Ljava/lang/Object;
    move-object v5, v4

    check-cast v5, Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;

    .local v5, "it":Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;
    const/4 v6, 0x0

    .line 286
    .local v6, "$i$a$-forEach-FileSystemManager$onStart$1":I
    invoke-interface {v5, p1, p2}, Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;->onStart(Ljava/lang/String;Ljava/lang/String;)V

    .line 438
    .end local v5    # "it":Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;
    .end local v6    # "$i$a$-forEach-FileSystemManager$onStart$1":I
    nop

    .end local v4    # "element$iv":Ljava/lang/Object;
    goto :goto_1

    .line 439
    :cond_1
    nop

    .line 287
    .end local v1    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v2    # "$i$f$forEach":I
    return-void
.end method


# virtual methods
.method public addFileUploadListener(Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 301
    sget-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->mFileUploadListeners:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/CopyOnWriteArrayList;->addIfAbsent(Ljava/lang/Object;)Z

    .line 302
    return-void
.end method

.method public final decrementFileReference(Ljava/lang/String;)I
    .locals 5
    .param p1, "filePath"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 80
    sget-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->fileReferenceCount:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/concurrent/atomic/AtomicInteger;

    .line 81
    .local v0, "counter":Ljava/util/concurrent/atomic/AtomicInteger;
    if-nez v0, :cond_0

    .line 82
    sget-object v1, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "\u6587\u4ef6\u5f15\u7528\u8ba1\u6570\u5668\u4e0d\u5b58\u5728: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 83
    const/4 v1, 0x0

    return v1

    .line 85
    :cond_0
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->decrementAndGet()I

    move-result v1

    .line 86
    .local v1, "count":I
    sget-object v2, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "\u6587\u4ef6\u5f15\u7528\u8ba1\u6570-1: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", \u5f53\u524d\u8ba1\u6570="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 87
    if-gtz v1, :cond_1

    .line 88
    sget-object v2, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->fileReferenceCount:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v2, p1}, Ljava/util/concurrent/ConcurrentHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 89
    sget-object v2, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "\u6587\u4ef6\u5f15\u7528\u8ba1\u6570\u5f52\u96f6\uff0c\u53ef\u4ee5\u5b89\u5168\u5220\u9664: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 91
    :cond_1
    return v1
.end method

.method public final getFileReferenceCount(Ljava/lang/String;)I
    .locals 1
    .param p1, "filePath"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 98
    sget-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->fileReferenceCount:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/concurrent/atomic/AtomicInteger;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->get()I

    move-result v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public final getMimeType(Ljava/io/File;)Ljava/lang/String;
    .locals 11
    .param p1, "file"    # Ljava/io/File;

    const-string v0, "file"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 390
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v0

    check-cast v0, Landroid/content/Context;

    .line 391
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v2

    invoke-virtual {v2}, Landroid/app/Application;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ".fileprovider"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 392
    nop

    .line 389
    invoke-static {v0, v1, p1}, Landroidx/core/content/FileProvider;->getUriForFile(Landroid/content/Context;Ljava/lang/String;Ljava/io/File;)Landroid/net/Uri;

    move-result-object v0

    .line 393
    .local v0, "uri":Landroid/net/Uri;
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v1

    invoke-virtual {v1}, Landroid/app/Application;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/content/ContentResolver;->getType(Landroid/net/Uri;)Ljava/lang/String;

    move-result-object v1

    if-nez v1, :cond_0

    const-string v1, ""

    .line 394
    .local v1, "mimeType":Ljava/lang/String;
    :cond_0
    move-object v2, v1

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 395
    sget-object v2, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->TAG:Ljava/lang/String;

    const-string v3, "mimeType is null"

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 396
    invoke-virtual {p1}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v2

    const-string v3, "file.path"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v5, v4

    check-cast v5, Ljava/lang/CharSequence;

    const/4 v9, 0x6

    const/4 v10, 0x0

    const-string v6, "."

    const/4 v7, 0x0

    const/4 v8, 0x0

    invoke-static/range {v5 .. v10}, Lkotlin/text/StringsKt;->lastIndexOf$default(Ljava/lang/CharSequence;Ljava/lang/String;IZILjava/lang/Object;)I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v2

    const-string/jumbo v3, "this as java.lang.String).substring(startIndex)"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v1, v2

    .line 397
    sget-object v2, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "mimeType get suffix is "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_0

    .line 399
    :cond_1
    sget-object v2, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "contentResolver.getType "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 401
    :goto_0
    return-object v1
.end method

.method public final incrementFileReference(Ljava/lang/String;)I
    .locals 5
    .param p1, "filePath"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 69
    sget-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->fileReferenceCount:Ljava/util/concurrent/ConcurrentHashMap;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$incrementFileReference$counter$1;->INSTANCE:Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$incrementFileReference$counter$1;

    check-cast v1, Lkotlin/jvm/functions/Function1;

    new-instance v2, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$$ExternalSyntheticLambda0;

    invoke-direct {v2, v1}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$$ExternalSyntheticLambda0;-><init>(Lkotlin/jvm/functions/Function1;)V

    invoke-virtual {v0, p1, v2}, Ljava/util/concurrent/ConcurrentHashMap;->computeIfAbsent(Ljava/lang/Object;Ljava/util/function/Function;)Ljava/lang/Object;

    move-result-object v0

    const-string v1, "fileReferenceCount.compu\u2026ath) { AtomicInteger(0) }"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v0, Ljava/util/concurrent/atomic/AtomicInteger;

    .line 70
    .local v0, "counter":Ljava/util/concurrent/atomic/AtomicInteger;
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I

    move-result v1

    .line 71
    .local v1, "count":I
    sget-object v2, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "\u6587\u4ef6\u5f15\u7528\u8ba1\u6570+1: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", \u5f53\u524d\u8ba1\u6570="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 72
    return v1
.end method

.method public final initFileSystem()V
    .locals 2

    .line 110
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$mInterMessageListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->addInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V

    .line 111
    return-void
.end method

.method public final isCloudUploadReady()Z
    .locals 1

    .line 207
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->isCloudUploadAuthReady()Z

    move-result v0

    return v0
.end method

.method public final isFileSafeToDelete(Ljava/lang/String;)Z
    .locals 1
    .param p1, "filePath"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 105
    invoke-virtual {p0, p1}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->getFileReferenceCount(Ljava/lang/String;)I

    move-result v0

    if-gtz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public final minioFileUpload(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V
    .locals 14
    .param p1, "filePath"    # Ljava/lang/String;
    .param p2, "tag"    # Ljava/lang/String;
    .param p3, "category"    # Ljava/lang/String;
    .param p4, "captureTime"    # J

    move-object v10, p1

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "tag"

    move-object/from16 v11, p2

    invoke-static {v11, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "category"

    move-object/from16 v12, p3

    invoke-static {v12, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 350
    invoke-virtual {p0, p1}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->incrementFileReference(Ljava/lang/String;)I

    .line 353
    sget-object v0, Lcom/rokid/security/phone/sdk/base/utils/other/FileUtil;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/other/FileUtil;

    new-instance v1, Ljava/io/File;

    invoke-direct {v1, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/other/FileUtil;->generateMD5(Ljava/io/File;)Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_0

    const-string v0, ""

    :cond_0
    move-object v13, v0

    .line 354
    .local v13, "preCalculatedMd5":Ljava/lang/String;
    sget-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "minioFileUpload md5Ready="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move-object v2, v13

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v2}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v2

    xor-int/lit8 v2, v2, 0x1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 356
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->getMFileSystemRepository()Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    move-result-object v0

    new-instance v1, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$minioFileUpload$1;

    invoke-direct {v1, p1, v13}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$minioFileUpload$1;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    move-object v6, v1

    check-cast v6, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    const/16 v8, 0x20

    const/4 v9, 0x0

    const/4 v7, 0x0

    move-object v1, p1

    move-object/from16 v2, p2

    move-object/from16 v3, p3

    move-wide/from16 v4, p4

    invoke-static/range {v0 .. v9}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;->minioFileUpload$default(Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;JLcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;ZILjava/lang/Object;)V

    .line 379
    return-void
.end method

.method public final onMessage(Ljava/lang/String;)V
    .locals 12
    .param p1, "msg"    # Ljava/lang/String;

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 139
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const-string v1, "FILE_SYSTEM_ACTION"

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x0

    const/4 v3, 0x2

    const/4 v4, 0x0

    invoke-static {v0, v1, v2, v3, v4}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    .line 140
    sget-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "onMessage:"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 141
    sget-object v0, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v0

    const-class v1, Lcom/rokid/security/sdk/base/common/RkBaseData;

    invoke-virtual {v0, p1, v1}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/base/common/RkBaseData;

    .line 142
    .local v0, "rkBaseData":Lcom/rokid/security/sdk/base/common/RkBaseData;
    new-instance v1, Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {v1}, Lkotlin/jvm/internal/Ref$ObjectRef;-><init>()V

    .line 143
    .local v1, "mFileSystemExtra":Lkotlin/jvm/internal/Ref$ObjectRef;
    sget-object v3, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v3

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/RkBaseData;->getExtra()Ljava/lang/String;

    move-result-object v5

    const-class v6, Lcom/rokid/security/sdk/base/common/FileSystemExtra;

    invoke-virtual {v3, v5, v6}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v3

    .line 142
    iput-object v3, v1, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 145
    new-instance v3, Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {v3}, Lkotlin/jvm/internal/Ref$ObjectRef;-><init>()V

    .local v3, "device_meta":Lkotlin/jvm/internal/Ref$ObjectRef;
    new-instance v5, Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;

    invoke-direct {v5}, Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;-><init>()V

    iput-object v5, v3, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 146
    iget-object v5, v1, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v5, Lcom/rokid/security/sdk/base/common/FileSystemExtra;

    invoke-virtual {v5}, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->getDeviceMetaJson()Ljava/lang/String;

    move-result-object v5

    check-cast v5, Ljava/lang/CharSequence;

    invoke-interface {v5}, Ljava/lang/CharSequence;->length()I

    move-result v5

    if-lez v5, :cond_0

    const/4 v2, 0x1

    :cond_0
    if-eqz v2, :cond_1

    .line 147
    nop

    .line 148
    sget-object v2, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->mGson:Lcom/google/gson/Gson;

    iget-object v5, v1, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v5, Lcom/rokid/security/sdk/base/common/FileSystemExtra;

    invoke-virtual {v5}, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->getDeviceMetaJson()Ljava/lang/String;

    move-result-object v5

    const-class v6, Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;

    invoke-virtual {v2, v5, v6}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v2

    const-string v5, "mGson.fromJson(mFileSyst\u2026, DeviceMeta::class.java)"

    invoke-static {v2, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 147
    iput-object v2, v3, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 149
    iget-object v2, v3, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v2, Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;

    iget-object v5, v3, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v5, Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;

    invoke-virtual {v5}, Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;->getGlassId()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v2, v5}, Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;->setDeviceId(Ljava/lang/String;)V

    .line 151
    :cond_1
    iget-object v2, v1, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v2, Lcom/rokid/security/sdk/base/common/FileSystemExtra;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->getMethodName()Ljava/lang/String;

    move-result-object v2

    const-string/jumbo v5, "sendUploadFileTask"

    invoke-static {v2, v5}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_5

    .line 154
    new-instance v2, Ljava/io/File;

    iget-object v5, v1, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v5, Lcom/rokid/security/sdk/base/common/FileSystemExtra;

    invoke-virtual {v5}, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->getFilePath()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v2, v5}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v2

    const-string v5, ""

    if-nez v2, :cond_2

    .line 155
    iget-object v2, v1, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v2, Lcom/rokid/security/sdk/base/common/FileSystemExtra;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->getFilePath()Ljava/lang/String;

    move-result-object v2

    const-string/jumbo v4, "\u6587\u4ef6\u4e0d\u5b58\u5728"

    invoke-direct {p0, v4, v5, v2}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->onErrorListener(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 156
    return-void

    .line 158
    :cond_2
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->isCloudUploadAuthReady()Z

    move-result v2

    if-nez v2, :cond_3

    .line 159
    sget-object v2, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "cloud upload auth not ready, defer by caller retry file="

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v6, v1, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v6, Lcom/rokid/security/sdk/base/common/FileSystemExtra;

    invoke-virtual {v6}, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->getFilePath()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v2, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 160
    iget-object v2, v1, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v2, Lcom/rokid/security/sdk/base/common/FileSystemExtra;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->getFilePath()Ljava/lang/String;

    move-result-object v2

    const-string v4, "auth_pending:\u624b\u673a\u7aef\u767b\u5f55\u6001\u672a\u5c31\u7eea\uff0c\u7b49\u5f85 token \u5237\u65b0"

    invoke-direct {p0, v4, v5, v2}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->onErrorListener(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 161
    return-void

    .line 163
    :cond_3
    iget-object v2, v1, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v2, Lcom/rokid/security/sdk/base/common/FileSystemExtra;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->getLastModifiedTime()J

    move-result-wide v5

    const-wide/16 v7, 0x0

    cmp-long v2, v5, v7

    if-eqz v2, :cond_4

    .line 164
    iget-object v2, v1, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v2, Lcom/rokid/security/sdk/base/common/FileSystemExtra;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->getFilePath()Ljava/lang/String;

    move-result-object v2

    iget-object v5, v1, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v5, Lcom/rokid/security/sdk/base/common/FileSystemExtra;

    invoke-virtual {v5}, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->getLastModifiedTime()J

    move-result-wide v5

    invoke-virtual {p0, v2, v5, v6}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->updateFileLastModified(Ljava/lang/String;J)Z

    move-result v2

    .line 165
    .local v2, "success":Z
    sget-object v5, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v7, "updateFileCreationTime success  "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 167
    .end local v2    # "success":Z
    :cond_4
    sget-object v2, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v6, "updateFileCreationTime fileCreateTime "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, v1, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v6, Lcom/rokid/security/sdk/base/common/FileSystemExtra;

    invoke-virtual {v6}, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->getLastModifiedTime()J

    move-result-wide v6

    invoke-virtual {v5, v6, v7}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " lastModified:"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    new-instance v6, Ljava/io/File;

    iget-object v7, v1, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v7, Lcom/rokid/security/sdk/base/common/FileSystemExtra;

    invoke-virtual {v7}, Lcom/rokid/security/sdk/base/common/FileSystemExtra;->getFilePath()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, v7}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6}, Ljava/io/File;->lastModified()J

    move-result-wide v6

    invoke-virtual {v5, v6, v7}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v2, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 168
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getWorkScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v6

    new-instance v2, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$onMessage$1;

    invoke-direct {v2, v1, v3, v4}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$onMessage$1;-><init>(Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/jvm/internal/Ref$ObjectRef;Lkotlin/coroutines/Continuation;)V

    move-object v9, v2

    check-cast v9, Lkotlin/jvm/functions/Function2;

    const/4 v10, 0x3

    const/4 v11, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    invoke-static/range {v6 .. v11}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 188
    .end local v0    # "rkBaseData":Lcom/rokid/security/sdk/base/common/RkBaseData;
    .end local v1    # "mFileSystemExtra":Lkotlin/jvm/internal/Ref$ObjectRef;
    .end local v3    # "device_meta":Lkotlin/jvm/internal/Ref$ObjectRef;
    :cond_5
    return-void
.end method

.method public final ossFileUpload(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V
    .locals 15
    .param p1, "filePath"    # Ljava/lang/String;
    .param p2, "tag"    # Ljava/lang/String;
    .param p3, "category"    # Ljava/lang/String;
    .param p4, "captureTime"    # J

    move-object/from16 v11, p1

    const-string v0, "filePath"

    invoke-static {v11, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "tag"

    move-object/from16 v12, p2

    invoke-static {v12, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "category"

    move-object/from16 v13, p3

    invoke-static {v13, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 318
    invoke-virtual/range {p0 .. p1}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->incrementFileReference(Ljava/lang/String;)I

    .line 321
    sget-object v0, Lcom/rokid/security/phone/sdk/base/utils/other/FileUtil;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/other/FileUtil;

    new-instance v1, Ljava/io/File;

    invoke-direct {v1, v11}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/other/FileUtil;->generateMD5(Ljava/io/File;)Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_0

    const-string v0, ""

    :cond_0
    move-object v14, v0

    .line 322
    .local v14, "preCalculatedMd5":Ljava/lang/String;
    sget-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "ossFileUpload md5Ready="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move-object v2, v14

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v2}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v2

    xor-int/lit8 v2, v2, 0x1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 324
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->getMFileSystemRepository()Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    move-result-object v0

    sget-object v1, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$1;->INSTANCE:Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$1;

    move-object v6, v1

    check-cast v6, Lkotlin/jvm/functions/Function1;

    .line 326
    new-instance v1, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2;

    invoke-direct {v1, v11, v14}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager$ossFileUpload$2;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    move-object v7, v1

    check-cast v7, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    .line 324
    const/16 v9, 0x40

    const/4 v10, 0x0

    const/4 v8, 0x0

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    move-object/from16 v3, p3

    move-wide/from16 v4, p4

    invoke-static/range {v0 .. v10}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;->ossFileUpload$default(Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;JLkotlin/jvm/functions/Function1;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;ZILjava/lang/Object;)V

    .line 346
    return-void
.end method

.method public removeFileUploadListener()V
    .locals 1

    .line 297
    sget-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->mFileUploadListeners:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;->clear()V

    .line 298
    return-void
.end method

.method public final removeFileUploadListener(Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 305
    sget-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->mFileUploadListeners:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/CopyOnWriteArrayList;->remove(Ljava/lang/Object;)Z

    .line 306
    return-void
.end method

.method public setFileUploadListener(Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/security/phone/sdk/api/filesystem/api/FileUploadListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 292
    sget-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->mFileUploadListeners:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;->clear()V

    .line 293
    sget-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->mFileUploadListeners:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/CopyOnWriteArrayList;->addIfAbsent(Ljava/lang/Object;)Z

    .line 294
    return-void
.end method

.method public final updateFileLastModified(Ljava/lang/String;J)Z
    .locals 5
    .param p1, "filePath"    # Ljava/lang/String;
    .param p2, "targetTime"    # J

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 408
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 409
    .local v0, "file":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    const/4 v2, 0x0

    if-nez v1, :cond_0

    .line 410
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "\u6587\u4ef6\u4e0d\u5b58\u5728\uff1a"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    sget-object v3, Ljava/lang/System;->out:Ljava/io/PrintStream;

    invoke-virtual {v3, v1}, Ljava/io/PrintStream;->println(Ljava/lang/Object;)V

    .line 411
    return v2

    .line 415
    :cond_0
    const-wide/16 v3, 0x0

    cmp-long v1, p2, v3

    if-gez v1, :cond_1

    .line 416
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "\u76ee\u6807\u65f6\u95f4\u6233\u65e0\u6548\uff1a"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2, p3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string/jumbo v3, "\uff08\u9700 >= 0\uff09"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    sget-object v3, Ljava/lang/System;->out:Ljava/io/PrintStream;

    invoke-virtual {v3, v1}, Ljava/io/PrintStream;->println(Ljava/lang/Object;)V

    .line 417
    return v2

    .line 421
    :cond_1
    invoke-virtual {v0, p2, p3}, Ljava/io/File;->setLastModified(J)Z

    move-result v1

    .line 422
    .local v1, "isSuccess":Z
    if-eqz v1, :cond_2

    .line 423
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "\u6700\u540e\u4fee\u6539\u65f6\u95f4\u66f4\u65b0\u6210\u529f\uff1a\u76ee\u6807\u65f6\u95f4="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2, p3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string/jumbo v3, "\uff0c\u5b9e\u9645\u65f6\u95f4="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/io/File;->lastModified()J

    move-result-wide v3

    invoke-virtual {v2, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    sget-object v3, Ljava/lang/System;->out:Ljava/io/PrintStream;

    invoke-virtual {v3, v2}, Ljava/io/PrintStream;->println(Ljava/lang/Object;)V

    goto :goto_0

    .line 425
    :cond_2
    const-string/jumbo v2, "\u6700\u540e\u4fee\u6539\u65f6\u95f4\u66f4\u65b0\u5931\u8d25\uff1a\u53ef\u80fd\u65e0\u6743\u9650\u6216\u6587\u4ef6\u7cfb\u7edf\u4e0d\u652f\u6301"

    sget-object v3, Ljava/lang/System;->out:Ljava/io/PrintStream;

    invoke-virtual {v3, v2}, Ljava/io/PrintStream;->println(Ljava/lang/Object;)V

    .line 427
    :goto_0
    return v1
.end method

.method public final useMinio()Z
    .locals 2

    .line 191
    sget-object v0, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getEnvType()Ljava/lang/String;

    move-result-object v0

    const-string v1, "custom"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method
