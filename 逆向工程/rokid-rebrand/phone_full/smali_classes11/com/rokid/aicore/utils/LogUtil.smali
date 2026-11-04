.class public final Lcom/rokid/aicore/utils/LogUtil;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/aicore/utils/LogUtil$Companion;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u000c\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0003\u0018\u0000 \u00032\u00020\u0001:\u0001\u0003B\u0005\u00a2\u0006\u0002\u0010\u0002\u00a8\u0006\u0004"
    }
    d2 = {
        "Lcom/rokid/aicore/utils/LogUtil;",
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
.field public static final Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

.field private static final TAG:Ljava/lang/String; = "AICore"

.field private static mEnable:Z


# direct methods
.method public static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/aicore/utils/LogUtil$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/aicore/utils/LogUtil$Companion;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lcom/rokid/aicore/utils/LogUtil;->Companion:Lcom/rokid/aicore/utils/LogUtil$Companion;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static final synthetic access$getMEnable$cp()Z
    .locals 1

    sget-boolean v0, Lcom/rokid/aicore/utils/LogUtil;->mEnable:Z

    return v0
.end method

.method public static final synthetic access$setMEnable$cp(Z)V
    .locals 0

    sput-boolean p0, Lcom/rokid/aicore/utils/LogUtil;->mEnable:Z

    return-void
.end method
