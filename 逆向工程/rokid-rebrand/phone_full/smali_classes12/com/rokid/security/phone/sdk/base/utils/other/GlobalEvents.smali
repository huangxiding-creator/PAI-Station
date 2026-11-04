.class public final Lcom/rokid/security/phone/sdk/base/utils/other/GlobalEvents;
.super Ljava/lang/Object;
.source "GlobalEvents.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001c\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0003\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002R\u000e\u0010\u0003\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u0017\u0010\u0007\u001a\u0008\u0012\u0004\u0012\u00020\u00040\u0008\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\t\u0010\n\u00a8\u0006\u000b"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/base/utils/other/GlobalEvents;",
        "",
        "()V",
        "APP_AUTH_EXPIRED",
        "",
        "TOKEN_REFRESH_DONE_FAILED",
        "TOKEN_REFRESH_DONE_SUCCESS",
        "message",
        "Landroidx/lifecycle/MutableLiveData;",
        "getMessage",
        "()Landroidx/lifecycle/MutableLiveData;",
        "base-utils_release"
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
.field public static final APP_AUTH_EXPIRED:Ljava/lang/String; = "AppAuthExpired"

.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/other/GlobalEvents;

.field public static final TOKEN_REFRESH_DONE_FAILED:Ljava/lang/String; = "TokenRefreshDoneFailed"

.field public static final TOKEN_REFRESH_DONE_SUCCESS:Ljava/lang/String; = "TokenRefreshDoneSuccess"

.field private static final message:Landroidx/lifecycle/MutableLiveData;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroidx/lifecycle/MutableLiveData<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/base/utils/other/GlobalEvents;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/base/utils/other/GlobalEvents;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/base/utils/other/GlobalEvents;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/other/GlobalEvents;

    .line 14
    new-instance v0, Landroidx/lifecycle/MutableLiveData;

    invoke-direct {v0}, Landroidx/lifecycle/MutableLiveData;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/base/utils/other/GlobalEvents;->message:Landroidx/lifecycle/MutableLiveData;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final getMessage()Landroidx/lifecycle/MutableLiveData;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Landroidx/lifecycle/MutableLiveData<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 14
    sget-object v0, Lcom/rokid/security/phone/sdk/base/utils/other/GlobalEvents;->message:Landroidx/lifecycle/MutableLiveData;

    return-object v0
.end method
