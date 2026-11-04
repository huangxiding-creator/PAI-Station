.class public final enum Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;
.super Ljava/lang/Enum;
.source "MotConfig.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/aicore/ncnn/bean/MotConfig;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "TrackerType"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;

.field public static final enum kTrackerTypeByteTracker:Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;

.field public static final enum kTrackerTypeCount:Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;

.field public static final enum kTrackerTypeDeepSORT:Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;

.field public static final enum kTrackerTypeOcvTracking:Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;


# direct methods
.method private static synthetic $values()[Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;
    .locals 4

    .line 372
    sget-object v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;->kTrackerTypeByteTracker:Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;

    sget-object v1, Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;->kTrackerTypeDeepSORT:Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;

    sget-object v2, Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;->kTrackerTypeOcvTracking:Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;

    sget-object v3, Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;->kTrackerTypeCount:Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;

    filled-new-array {v0, v1, v2, v3}, [Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;

    move-result-object v0

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 3

    .line 373
    new-instance v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;

    const-string v1, "kTrackerTypeByteTracker"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;->kTrackerTypeByteTracker:Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;

    .line 374
    new-instance v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;

    const-string v1, "kTrackerTypeDeepSORT"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;->kTrackerTypeDeepSORT:Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;

    .line 375
    new-instance v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;

    const-string v1, "kTrackerTypeOcvTracking"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2}, Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;->kTrackerTypeOcvTracking:Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;

    .line 376
    new-instance v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;

    const-string v1, "kTrackerTypeCount"

    const/4 v2, 0x3

    invoke-direct {v0, v1, v2}, Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;->kTrackerTypeCount:Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;

    .line 372
    invoke-static {}, Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;->$values()[Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;

    move-result-object v0

    sput-object v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;->$VALUES:[Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 372
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 372
    const-class v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;

    return-object v0
.end method

.method public static values()[Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;
    .locals 1

    .line 372
    sget-object v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;->$VALUES:[Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;

    invoke-virtual {v0}, [Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/rokid/aicore/ncnn/bean/MotConfig$TrackerType;

    return-object v0
.end method
