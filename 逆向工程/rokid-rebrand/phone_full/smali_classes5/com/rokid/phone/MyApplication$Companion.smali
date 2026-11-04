.class public final Lcom/rokid/phone/MyApplication$Companion;
.super Ljava/lang/Object;
.source "MyApplication.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/phone/MyApplication;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Companion"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001a\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010\u000e\n\u0000\u0008\u0086\u0003\u0018\u00002\u00020\u0001B\t\u0008\u0002\u00a2\u0006\u0004\u0008\u0002\u0010\u0003R\u001a\u0010\u0004\u001a\u00020\u0005X\u0086.\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0006\u0010\u0007\"\u0004\u0008\u0008\u0010\tR\u000e\u0010\n\u001a\u00020\u000bX\u0086T\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u000c"
    }
    d2 = {
        "Lcom/rokid/phone/MyApplication$Companion;",
        "",
        "<init>",
        "()V",
        "instance",
        "Lcom/rokid/phone/MyApplication;",
        "getInstance",
        "()Lcom/rokid/phone/MyApplication;",
        "setInstance",
        "(Lcom/rokid/phone/MyApplication;)V",
        "MainAppClientId",
        "",
        "app_debug"
    }
    k = 0x1
    mv = {
        0x2,
        0x2,
        0x0
    }
    xi = 0x30
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public synthetic constructor <init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V
    .locals 0

    invoke-direct {p0}, Lcom/rokid/phone/MyApplication$Companion;-><init>()V

    return-void
.end method


# virtual methods
.method public final getInstance()Lcom/rokid/phone/MyApplication;
    .locals 1

    .line 7
    sget-object v0, Lcom/rokid/phone/MyApplication;->instance:Lcom/rokid/phone/MyApplication;

    if-eqz v0, :cond_0

    return-object v0

    :cond_0
    const-string v0, "instance"

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    const/4 v0, 0x0

    return-object v0
.end method

.method public final setInstance(Lcom/rokid/phone/MyApplication;)V
    .locals 1
    .param p1, "<set-?>"    # Lcom/rokid/phone/MyApplication;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 7
    sput-object p1, Lcom/rokid/phone/MyApplication;->instance:Lcom/rokid/phone/MyApplication;

    return-void
.end method
