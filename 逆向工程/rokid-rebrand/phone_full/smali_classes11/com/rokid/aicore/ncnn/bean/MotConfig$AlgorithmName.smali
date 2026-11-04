.class public final enum Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;
.super Ljava/lang/Enum;
.source "MotConfig.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/aicore/ncnn/bean/MotConfig;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "AlgorithmName"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

.field public static final enum kAlgorithmFaceDet:Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

.field public static final enum kAlgorithmMotorRec:Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

.field public static final enum kAlgorithmPlateRec:Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;


# direct methods
.method private static synthetic $values()[Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;
    .locals 3

    .line 380
    sget-object v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->kAlgorithmFaceDet:Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    sget-object v1, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->kAlgorithmPlateRec:Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    sget-object v2, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->kAlgorithmMotorRec:Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    filled-new-array {v0, v1, v2}, [Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    move-result-object v0

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 3

    .line 381
    new-instance v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    const-string v1, "kAlgorithmFaceDet"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->kAlgorithmFaceDet:Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    .line 382
    new-instance v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    const-string v1, "kAlgorithmPlateRec"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->kAlgorithmPlateRec:Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    .line 383
    new-instance v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    const-string v1, "kAlgorithmMotorRec"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2}, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->kAlgorithmMotorRec:Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    .line 380
    invoke-static {}, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->$values()[Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    move-result-object v0

    sput-object v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->$VALUES:[Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 380
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 380
    const-class v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    return-object v0
.end method

.method public static values()[Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;
    .locals 1

    .line 380
    sget-object v0, Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->$VALUES:[Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    invoke-virtual {v0}, [Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/rokid/aicore/ncnn/bean/MotConfig$AlgorithmName;

    return-object v0
.end method
