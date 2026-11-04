.class public final enum Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;
.super Ljava/lang/Enum;
.source "MotConfig.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/aicore/ncnn/bean/MotConfig;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "ImageType"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

.field public static final enum kImageTypeBRG:Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

.field public static final enum kImageTypeCount:Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

.field public static final enum kImageTypeNV12:Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

.field public static final enum kImageTypeNV21:Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

.field public static final enum kImageTypeRGB:Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;


# direct methods
.method private static synthetic $values()[Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;
    .locals 5

    .line 362
    sget-object v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;->kImageTypeNV21:Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    sget-object v1, Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;->kImageTypeNV12:Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    sget-object v2, Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;->kImageTypeRGB:Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    sget-object v3, Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;->kImageTypeBRG:Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    sget-object v4, Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;->kImageTypeCount:Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    filled-new-array {v0, v1, v2, v3, v4}, [Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    move-result-object v0

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 3

    .line 363
    new-instance v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    const-string v1, "kImageTypeNV21"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;->kImageTypeNV21:Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    .line 364
    new-instance v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    const-string v1, "kImageTypeNV12"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;->kImageTypeNV12:Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    .line 365
    new-instance v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    const-string v1, "kImageTypeRGB"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2}, Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;->kImageTypeRGB:Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    .line 366
    new-instance v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    const-string v1, "kImageTypeBRG"

    const/4 v2, 0x3

    invoke-direct {v0, v1, v2}, Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;->kImageTypeBRG:Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    .line 367
    new-instance v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    const-string v1, "kImageTypeCount"

    const/4 v2, 0x4

    invoke-direct {v0, v1, v2}, Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;->kImageTypeCount:Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    .line 362
    invoke-static {}, Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;->$values()[Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    move-result-object v0

    sput-object v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;->$VALUES:[Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 362
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 362
    const-class v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    return-object v0
.end method

.method public static values()[Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;
    .locals 1

    .line 362
    sget-object v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;->$VALUES:[Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    invoke-virtual {v0}, [Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/rokid/aicore/ncnn/bean/MotConfig$ImageType;

    return-object v0
.end method
