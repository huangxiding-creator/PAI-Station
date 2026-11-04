.class public Lcom/rokid/aicore/utils/Constants;
.super Ljava/lang/Object;


# static fields
.field public static final DEFAULT_MAX_FEATURE:I = 0x493e0

.field public static final MASK_ARMAZ:I = 0x80

.field public static final MASK_DM:I = 0x10

.field public static final MASK_FACE:I = 0x1

.field public static final MASK_GESTURE:I = 0x4

.field public static final MASK_IDCARD:I = 0x20

.field public static final MASK_INFRARED_FACE:I = 0x40

.field public static final MASK_LPR:I = 0x2

.field public static final MASK_NAMEPLATE:I = 0x200

.field public static final MASK_OBJECT:I = 0x100

.field public static final MASK_PM:I = 0x8

.field public static final VALUE_FALSE:Ljava/lang/String; = "false"

.field public static final VALUE_TRUE:Ljava/lang/String; = "true"

.field public static mTimeStamps:Landroid/util/LruCache;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/util/LruCache<",
            "Ljava/lang/Long;",
            "Lcom/rokid/aicore/bean/ExecTimeStamp;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public static constructor <clinit>()V
    .locals 2

    new-instance v0, Landroid/util/LruCache;

    const/16 v1, 0x3c

    invoke-direct {v0, v1}, Landroid/util/LruCache;-><init>(I)V

    sput-object v0, Lcom/rokid/aicore/utils/Constants;->mTimeStamps:Landroid/util/LruCache;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getExecuteTimeStamp(J)Lcom/rokid/aicore/bean/ExecTimeStamp;
    .locals 2

    sget-object v0, Lcom/rokid/aicore/utils/Constants;->mTimeStamps:Landroid/util/LruCache;

    invoke-static {p0, p1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/util/LruCache;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/aicore/bean/ExecTimeStamp;

    if-nez v0, :cond_0

    new-instance p0, Lcom/rokid/aicore/bean/ExecTimeStamp;

    invoke-direct {p0}, Lcom/rokid/aicore/bean/ExecTimeStamp;-><init>()V

    return-object p0

    :cond_0
    sget-object v0, Lcom/rokid/aicore/utils/Constants;->mTimeStamps:Landroid/util/LruCache;

    invoke-static {p0, p1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p0

    invoke-virtual {v0, p0}, Landroid/util/LruCache;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Lcom/rokid/aicore/bean/ExecTimeStamp;

    return-object p0
.end method

.method public static putExecuteTimeStamp(JLcom/rokid/aicore/bean/ExecTimeStamp;)V
    .locals 1

    sget-object v0, Lcom/rokid/aicore/utils/Constants;->mTimeStamps:Landroid/util/LruCache;

    invoke-static {p0, p1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p0

    invoke-virtual {v0, p0, p2}, Landroid/util/LruCache;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method public static removeExecuteTimeStamp(J)V
    .locals 1

    sget-object v0, Lcom/rokid/aicore/utils/Constants;->mTimeStamps:Landroid/util/LruCache;

    invoke-static {p0, p1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p0

    invoke-virtual {v0, p0}, Landroid/util/LruCache;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method
