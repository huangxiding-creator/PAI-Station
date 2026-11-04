.class public final enum Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;
.super Ljava/lang/Enum;
.source "FaceRecognizerWrapper.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "ImageType"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;

.field public static final enum BRG:Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;

.field public static final enum NV12:Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;

.field public static final enum NV21:Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;

.field public static final enum RGB:Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;


# direct methods
.method private static synthetic $values()[Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;
    .locals 4

    .line 24
    sget-object v0, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;->NV21:Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;

    sget-object v1, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;->NV12:Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;

    sget-object v2, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;->RGB:Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;

    sget-object v3, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;->BRG:Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;

    filled-new-array {v0, v1, v2, v3}, [Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;

    move-result-object v0

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 3

    .line 25
    new-instance v0, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;

    const-string v1, "NV21"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;->NV21:Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;

    .line 26
    new-instance v0, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;

    const-string v1, "NV12"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;->NV12:Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;

    .line 27
    new-instance v0, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;

    const-string v1, "RGB"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2}, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;->RGB:Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;

    .line 28
    new-instance v0, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;

    const-string v1, "BRG"

    const/4 v2, 0x3

    invoke-direct {v0, v1, v2}, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;->BRG:Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;

    .line 24
    invoke-static {}, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;->$values()[Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;

    move-result-object v0

    sput-object v0, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;->$VALUES:[Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 24
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 24
    const-class v0, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;

    return-object v0
.end method

.method public static values()[Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;
    .locals 1

    .line 24
    sget-object v0, Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;->$VALUES:[Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;

    invoke-virtual {v0}, [Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/rokid/aicore/ncnn/FaceRecognizerWrapper$ImageType;

    return-object v0
.end method
