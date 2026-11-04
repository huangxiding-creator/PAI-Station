.class public abstract enum Lcom/rokid/aicore/api/bean/DetectType;
.super Ljava/lang/Enum;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/aicore/api/bean/DetectType$LPR;,
        Lcom/rokid/aicore/api/bean/DetectType$FACE;,
        Lcom/rokid/aicore/api/bean/DetectType$MOTOR;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/rokid/aicore/api/bean/DetectType;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001a\n\u0002\u0018\u0002\n\u0002\u0010\u0010\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0004\n\u0002\u0010\u000e\n\u0002\u0008\u0004\u0008\u0086\u0001\u0018\u00002\u0008\u0012\u0004\u0012\u00020\u00000\u0001B\u000f\u0008\u0002\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\u0004J\u0008\u0010\u0007\u001a\u00020\u0008H&R\u0011\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006j\u0002\u0008\tj\u0002\u0008\nj\u0002\u0008\u000b\u00a8\u0006\u000c"
    }
    d2 = {
        "Lcom/rokid/aicore/api/bean/DetectType;",
        "",
        "value",
        "",
        "(Ljava/lang/String;II)V",
        "getValue",
        "()I",
        "getLabel",
        "",
        "LPR",
        "FACE",
        "MOTOR",
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
.field private static final synthetic $VALUES:[Lcom/rokid/aicore/api/bean/DetectType;

.field public static final enum FACE:Lcom/rokid/aicore/api/bean/DetectType;

.field public static final enum LPR:Lcom/rokid/aicore/api/bean/DetectType;

.field public static final enum MOTOR:Lcom/rokid/aicore/api/bean/DetectType;


# instance fields
.field private final value:I


# direct methods
.method private static final synthetic $values()[Lcom/rokid/aicore/api/bean/DetectType;
    .locals 3

    sget-object v0, Lcom/rokid/aicore/api/bean/DetectType;->LPR:Lcom/rokid/aicore/api/bean/DetectType;

    sget-object v1, Lcom/rokid/aicore/api/bean/DetectType;->FACE:Lcom/rokid/aicore/api/bean/DetectType;

    sget-object v2, Lcom/rokid/aicore/api/bean/DetectType;->MOTOR:Lcom/rokid/aicore/api/bean/DetectType;

    filled-new-array {v0, v1, v2}, [Lcom/rokid/aicore/api/bean/DetectType;

    move-result-object v0

    return-object v0
.end method

.method public static constructor <clinit>()V
    .locals 3

    new-instance v0, Lcom/rokid/aicore/api/bean/DetectType$LPR;

    const-string v1, "LPR"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/rokid/aicore/api/bean/DetectType$LPR;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/rokid/aicore/api/bean/DetectType;->LPR:Lcom/rokid/aicore/api/bean/DetectType;

    new-instance v0, Lcom/rokid/aicore/api/bean/DetectType$FACE;

    const-string v1, "FACE"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Lcom/rokid/aicore/api/bean/DetectType$FACE;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/rokid/aicore/api/bean/DetectType;->FACE:Lcom/rokid/aicore/api/bean/DetectType;

    new-instance v0, Lcom/rokid/aicore/api/bean/DetectType$MOTOR;

    const-string v1, "MOTOR"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2}, Lcom/rokid/aicore/api/bean/DetectType$MOTOR;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/rokid/aicore/api/bean/DetectType;->MOTOR:Lcom/rokid/aicore/api/bean/DetectType;

    invoke-static {}, Lcom/rokid/aicore/api/bean/DetectType;->$values()[Lcom/rokid/aicore/api/bean/DetectType;

    move-result-object v0

    sput-object v0, Lcom/rokid/aicore/api/bean/DetectType;->$VALUES:[Lcom/rokid/aicore/api/bean/DetectType;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;II)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I)V"
        }
    .end annotation

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput p3, p0, Lcom/rokid/aicore/api/bean/DetectType;->value:I

    return-void
.end method

.method public synthetic constructor <init>(Ljava/lang/String;IILkotlin/jvm/internal/DefaultConstructorMarker;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lcom/rokid/aicore/api/bean/DetectType;-><init>(Ljava/lang/String;II)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/rokid/aicore/api/bean/DetectType;
    .locals 1

    const-string v0, "value"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-class v0, Lcom/rokid/aicore/api/bean/DetectType;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/rokid/aicore/api/bean/DetectType;

    return-object p0
.end method

.method public static values()[Lcom/rokid/aicore/api/bean/DetectType;
    .locals 2

    sget-object v0, Lcom/rokid/aicore/api/bean/DetectType;->$VALUES:[Lcom/rokid/aicore/api/bean/DetectType;

    array-length v1, v0

    invoke-static {v0, v1}, Ljava/util/Arrays;->copyOf([Ljava/lang/Object;I)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/rokid/aicore/api/bean/DetectType;

    return-object v0
.end method


# virtual methods
.method public abstract getLabel()Ljava/lang/String;
.end method

.method public final getValue()I
    .locals 1

    iget v0, p0, Lcom/rokid/aicore/api/bean/DetectType;->value:I

    return v0
.end method
