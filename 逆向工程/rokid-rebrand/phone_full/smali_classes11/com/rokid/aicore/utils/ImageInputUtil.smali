.class public final Lcom/rokid/aicore/utils/ImageInputUtil;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/aicore/utils/ImageInputUtil$Companion;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u000c\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0003\u0018\u0000 \u00032\u00020\u0001:\u0001\u0003B\u0005\u00a2\u0006\u0002\u0010\u0002\u00a8\u0006\u0004"
    }
    d2 = {
        "Lcom/rokid/aicore/utils/ImageInputUtil;",
        "",
        "()V",
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
.field public static final Companion:Lcom/rokid/aicore/utils/ImageInputUtil$Companion;

.field private static final TAG:Ljava/lang/String; = "ImageInputUtil"

.field private static mLruCache:Landroid/util/LruCache;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/util/LruCache<",
            "Ljava/lang/Long;",
            "Lcom/rokid/aicore/api/bean/ImageInput;",
            ">;"
        }
    .end annotation
.end field

.field private static mSaveFramesThreadPoolExecutor:Ljava/util/concurrent/ThreadPoolExecutor;


# direct methods
.method public static constructor <clinit>()V
    .locals 9

    new-instance v0, Lcom/rokid/aicore/utils/ImageInputUtil$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/aicore/utils/ImageInputUtil$Companion;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lcom/rokid/aicore/utils/ImageInputUtil;->Companion:Lcom/rokid/aicore/utils/ImageInputUtil$Companion;

    new-instance v0, Ljava/util/concurrent/ThreadPoolExecutor;

    sget-object v7, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    new-instance v8, Ljava/util/concurrent/LinkedBlockingQueue;

    const/16 v1, 0x1e

    invoke-direct {v8, v1}, Ljava/util/concurrent/LinkedBlockingQueue;-><init>(I)V

    const/4 v4, 0x1

    const-wide/16 v5, 0x0

    const/4 v3, 0x1

    move-object v2, v0

    invoke-direct/range {v2 .. v8}, Ljava/util/concurrent/ThreadPoolExecutor;-><init>(IIJLjava/util/concurrent/TimeUnit;Ljava/util/concurrent/BlockingQueue;)V

    sput-object v0, Lcom/rokid/aicore/utils/ImageInputUtil;->mSaveFramesThreadPoolExecutor:Ljava/util/concurrent/ThreadPoolExecutor;

    new-instance v0, Landroid/util/LruCache;

    const/16 v1, 0xa

    invoke-direct {v0, v1}, Landroid/util/LruCache;-><init>(I)V

    sput-object v0, Lcom/rokid/aicore/utils/ImageInputUtil;->mLruCache:Landroid/util/LruCache;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static final synthetic access$getMLruCache$cp()Landroid/util/LruCache;
    .locals 1

    sget-object v0, Lcom/rokid/aicore/utils/ImageInputUtil;->mLruCache:Landroid/util/LruCache;

    return-object v0
.end method

.method public static final synthetic access$getMSaveFramesThreadPoolExecutor$cp()Ljava/util/concurrent/ThreadPoolExecutor;
    .locals 1

    sget-object v0, Lcom/rokid/aicore/utils/ImageInputUtil;->mSaveFramesThreadPoolExecutor:Ljava/util/concurrent/ThreadPoolExecutor;

    return-object v0
.end method

.method public static final synthetic access$setMLruCache$cp(Landroid/util/LruCache;)V
    .locals 0

    sput-object p0, Lcom/rokid/aicore/utils/ImageInputUtil;->mLruCache:Landroid/util/LruCache;

    return-void
.end method

.method public static final synthetic access$setMSaveFramesThreadPoolExecutor$cp(Ljava/util/concurrent/ThreadPoolExecutor;)V
    .locals 0

    sput-object p0, Lcom/rokid/aicore/utils/ImageInputUtil;->mSaveFramesThreadPoolExecutor:Ljava/util/concurrent/ThreadPoolExecutor;

    return-void
.end method
