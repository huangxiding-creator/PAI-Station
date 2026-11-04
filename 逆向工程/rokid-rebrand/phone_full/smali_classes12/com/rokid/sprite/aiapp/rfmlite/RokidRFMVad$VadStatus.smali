.class public final enum Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;
.super Ljava/lang/Enum;
.source "RokidRFMVad.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "VadStatus"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0012\n\u0002\u0018\u0002\n\u0002\u0010\u0010\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0008\u0008\u0086\u0001\u0018\u00002\u0008\u0012\u0004\u0012\u00020\u00000\u0001B\u000f\u0008\u0002\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\u0004R\u0011\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006j\u0002\u0008\u0007j\u0002\u0008\u0008j\u0002\u0008\tj\u0002\u0008\n\u00a8\u0006\u000b"
    }
    d2 = {
        "Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;",
        "",
        "value",
        "",
        "(Ljava/lang/String;II)V",
        "getValue",
        "()I",
        "ERROR_CONFIG_NOT_EXIST",
        "NONE",
        "WAIT",
        "WAIT_TIMEOUT",
        "lib-rfmlite_release"
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
.field private static final synthetic $VALUES:[Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;

.field public static final enum ERROR_CONFIG_NOT_EXIST:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;

.field public static final enum NONE:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;

.field public static final enum WAIT:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;

.field public static final enum WAIT_TIMEOUT:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;


# instance fields
.field private final value:I


# direct methods
.method private static final synthetic $values()[Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;
    .locals 4

    sget-object v0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;->ERROR_CONFIG_NOT_EXIST:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;

    sget-object v1, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;->NONE:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;

    sget-object v2, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;->WAIT:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;

    sget-object v3, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;->WAIT_TIMEOUT:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;

    filled-new-array {v0, v1, v2, v3}, [Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;

    move-result-object v0

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 4

    .line 43
    new-instance v0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;

    const/4 v1, -0x1

    const-string v2, "ERROR_CONFIG_NOT_EXIST"

    const/4 v3, 0x0

    invoke-direct {v0, v2, v3, v1}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;->ERROR_CONFIG_NOT_EXIST:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;

    .line 44
    new-instance v0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;

    const-string v1, "NONE"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2, v3}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;->NONE:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;

    .line 45
    new-instance v0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;

    const-string v1, "WAIT"

    const/4 v3, 0x2

    invoke-direct {v0, v1, v3, v2}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;->WAIT:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;

    .line 46
    new-instance v0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;

    const-string v1, "WAIT_TIMEOUT"

    const/4 v2, 0x3

    invoke-direct {v0, v1, v2, v3}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;->WAIT_TIMEOUT:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;

    invoke-static {}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;->$values()[Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;

    move-result-object v0

    sput-object v0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;->$VALUES:[Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;II)V
    .locals 0
    .param p1, "$enum$name"    # Ljava/lang/String;
    .param p2, "$enum$ordinal"    # I
    .param p3, "value"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I)V"
        }
    .end annotation

    .line 42
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput p3, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;->value:I

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;
    .locals 1

    const-class v0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;

    return-object v0
.end method

.method public static values()[Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;
    .locals 1

    sget-object v0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;->$VALUES:[Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;

    invoke-virtual {v0}, [Ljava/lang/Object;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;

    return-object v0
.end method


# virtual methods
.method public final getValue()I
    .locals 1

    .line 42
    iget v0, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;->value:I

    return v0
.end method
