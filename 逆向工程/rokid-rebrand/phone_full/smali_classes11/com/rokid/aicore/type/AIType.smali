.class public final enum Lcom/rokid/aicore/type/AIType;
.super Ljava/lang/Enum;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/rokid/aicore/type/AIType;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0012\n\u0002\u0018\u0002\n\u0002\u0010\u0010\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0007\u0008\u0086\u0001\u0018\u00002\u0008\u0012\u0004\u0012\u00020\u00000\u0001B\u000f\u0008\u0002\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\u0004R\u0011\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006j\u0002\u0008\u0007j\u0002\u0008\u0008j\u0002\u0008\t\u00a8\u0006\n"
    }
    d2 = {
        "Lcom/rokid/aicore/type/AIType;",
        "",
        "value",
        "",
        "(Ljava/lang/String;ILjava/lang/String;)V",
        "getValue",
        "()Ljava/lang/String;",
        "FACE",
        "LPR",
        "MOTOR_LPR",
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
.field public static final enum FACE:Lcom/rokid/aicore/type/AIType;

.field public static final enum LPR:Lcom/rokid/aicore/type/AIType;

.field public static final enum MOTOR_LPR:Lcom/rokid/aicore/type/AIType;

.field public static final synthetic a:[Lcom/rokid/aicore/type/AIType;


# instance fields
.field private final value:Ljava/lang/String;


# direct methods
.method public static constructor <clinit>()V
    .locals 4

    new-instance v0, Lcom/rokid/aicore/type/AIType;

    const/4 v1, 0x0

    const-string v2, "R2_FACE"

    const-string v3, "FACE"

    invoke-direct {v0, v3, v1, v2}, Lcom/rokid/aicore/type/AIType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/rokid/aicore/type/AIType;->FACE:Lcom/rokid/aicore/type/AIType;

    new-instance v0, Lcom/rokid/aicore/type/AIType;

    const/4 v1, 0x1

    const-string v2, "R2_LPR"

    const-string v3, "LPR"

    invoke-direct {v0, v3, v1, v2}, Lcom/rokid/aicore/type/AIType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/rokid/aicore/type/AIType;->LPR:Lcom/rokid/aicore/type/AIType;

    new-instance v0, Lcom/rokid/aicore/type/AIType;

    const/4 v1, 0x2

    const-string v2, "R2_MOTOR_LPR"

    const-string v3, "MOTOR_LPR"

    invoke-direct {v0, v3, v1, v2}, Lcom/rokid/aicore/type/AIType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/rokid/aicore/type/AIType;->MOTOR_LPR:Lcom/rokid/aicore/type/AIType;

    invoke-static {}, Lcom/rokid/aicore/type/AIType;->a()[Lcom/rokid/aicore/type/AIType;

    move-result-object v0

    sput-object v0, Lcom/rokid/aicore/type/AIType;->a:[Lcom/rokid/aicore/type/AIType;

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;ILjava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput-object p3, p0, Lcom/rokid/aicore/type/AIType;->value:Ljava/lang/String;

    return-void
.end method

.method public static final synthetic a()[Lcom/rokid/aicore/type/AIType;
    .locals 3

    sget-object v0, Lcom/rokid/aicore/type/AIType;->FACE:Lcom/rokid/aicore/type/AIType;

    sget-object v1, Lcom/rokid/aicore/type/AIType;->LPR:Lcom/rokid/aicore/type/AIType;

    sget-object v2, Lcom/rokid/aicore/type/AIType;->MOTOR_LPR:Lcom/rokid/aicore/type/AIType;

    filled-new-array {v0, v1, v2}, [Lcom/rokid/aicore/type/AIType;

    move-result-object v0

    return-object v0
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/rokid/aicore/type/AIType;
    .locals 1

    const-string v0, "value"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-class v0, Lcom/rokid/aicore/type/AIType;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/rokid/aicore/type/AIType;

    return-object p0
.end method

.method public static values()[Lcom/rokid/aicore/type/AIType;
    .locals 2

    sget-object v0, Lcom/rokid/aicore/type/AIType;->a:[Lcom/rokid/aicore/type/AIType;

    array-length v1, v0

    invoke-static {v0, v1}, Ljava/util/Arrays;->copyOf([Ljava/lang/Object;I)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/rokid/aicore/type/AIType;

    return-object v0
.end method


# virtual methods
.method public final getValue()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/type/AIType;->value:Ljava/lang/String;

    return-object v0
.end method
