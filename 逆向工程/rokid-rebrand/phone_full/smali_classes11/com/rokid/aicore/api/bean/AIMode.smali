.class public final enum Lcom/rokid/aicore/api/bean/AIMode;
.super Ljava/lang/Enum;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/rokid/aicore/api/bean/AIMode;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0012\n\u0002\u0018\u0002\n\u0002\u0010\u0010\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0006\u0008\u0086\u0001\u0018\u00002\u0008\u0012\u0004\u0012\u00020\u00000\u0001B\u000f\u0008\u0002\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\u0004R\u0011\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006j\u0002\u0008\u0007j\u0002\u0008\u0008\u00a8\u0006\t"
    }
    d2 = {
        "Lcom/rokid/aicore/api/bean/AIMode;",
        "",
        "value",
        "",
        "(Ljava/lang/String;ILjava/lang/String;)V",
        "getValue",
        "()Ljava/lang/String;",
        "NORMAL",
        "NO_TRACK",
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
.field private static final synthetic $VALUES:[Lcom/rokid/aicore/api/bean/AIMode;

.field public static final enum NORMAL:Lcom/rokid/aicore/api/bean/AIMode;

.field public static final enum NO_TRACK:Lcom/rokid/aicore/api/bean/AIMode;


# instance fields
.field private final value:Ljava/lang/String;


# direct methods
.method private static final synthetic $values()[Lcom/rokid/aicore/api/bean/AIMode;
    .locals 2

    sget-object v0, Lcom/rokid/aicore/api/bean/AIMode;->NORMAL:Lcom/rokid/aicore/api/bean/AIMode;

    sget-object v1, Lcom/rokid/aicore/api/bean/AIMode;->NO_TRACK:Lcom/rokid/aicore/api/bean/AIMode;

    filled-new-array {v0, v1}, [Lcom/rokid/aicore/api/bean/AIMode;

    move-result-object v0

    return-object v0
.end method

.method public static constructor <clinit>()V
    .locals 4

    new-instance v0, Lcom/rokid/aicore/api/bean/AIMode;

    const/4 v1, 0x0

    const-string v2, "normal"

    const-string v3, "NORMAL"

    invoke-direct {v0, v3, v1, v2}, Lcom/rokid/aicore/api/bean/AIMode;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/rokid/aicore/api/bean/AIMode;->NORMAL:Lcom/rokid/aicore/api/bean/AIMode;

    new-instance v0, Lcom/rokid/aicore/api/bean/AIMode;

    const/4 v1, 0x1

    const-string v2, "no_track"

    const-string v3, "NO_TRACK"

    invoke-direct {v0, v3, v1, v2}, Lcom/rokid/aicore/api/bean/AIMode;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/rokid/aicore/api/bean/AIMode;->NO_TRACK:Lcom/rokid/aicore/api/bean/AIMode;

    invoke-static {}, Lcom/rokid/aicore/api/bean/AIMode;->$values()[Lcom/rokid/aicore/api/bean/AIMode;

    move-result-object v0

    sput-object v0, Lcom/rokid/aicore/api/bean/AIMode;->$VALUES:[Lcom/rokid/aicore/api/bean/AIMode;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;ILjava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput-object p3, p0, Lcom/rokid/aicore/api/bean/AIMode;->value:Ljava/lang/String;

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/rokid/aicore/api/bean/AIMode;
    .locals 1

    const-string v0, "value"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-class v0, Lcom/rokid/aicore/api/bean/AIMode;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/rokid/aicore/api/bean/AIMode;

    return-object p0
.end method

.method public static values()[Lcom/rokid/aicore/api/bean/AIMode;
    .locals 2

    sget-object v0, Lcom/rokid/aicore/api/bean/AIMode;->$VALUES:[Lcom/rokid/aicore/api/bean/AIMode;

    array-length v1, v0

    invoke-static {v0, v1}, Ljava/util/Arrays;->copyOf([Ljava/lang/Object;I)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/rokid/aicore/api/bean/AIMode;

    return-object v0
.end method


# virtual methods
.method public final getValue()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/api/bean/AIMode;->value:Ljava/lang/String;

    return-object v0
.end method
