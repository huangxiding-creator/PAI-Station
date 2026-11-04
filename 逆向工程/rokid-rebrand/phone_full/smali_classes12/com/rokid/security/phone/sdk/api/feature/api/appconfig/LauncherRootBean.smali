.class public final Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/LauncherRootBean;
.super Ljava/lang/Object;
.source "LauncherRootBean.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000 \n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010\t\n\u0002\u0008\u0006\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\"\u0010\u0003\u001a\n\u0012\u0004\u0012\u00020\u0005\u0018\u00010\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0006\u0010\u0007\"\u0004\u0008\u0008\u0010\tR\u001e\u0010\n\u001a\u0004\u0018\u00010\u000bX\u0086\u000e\u00a2\u0006\u0010\n\u0002\u0010\u0010\u001a\u0004\u0008\u000c\u0010\r\"\u0004\u0008\u000e\u0010\u000f\u00a8\u0006\u0011"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/LauncherRootBean;",
        "",
        "()V",
        "launchers",
        "",
        "Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/LauncherItemBean;",
        "getLaunchers",
        "()Ljava/util/List;",
        "setLaunchers",
        "(Ljava/util/List;)V",
        "updateAt",
        "",
        "getUpdateAt",
        "()Ljava/lang/Long;",
        "setUpdateAt",
        "(Ljava/lang/Long;)V",
        "Ljava/lang/Long;",
        "sdk-api_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field private launchers:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/LauncherItemBean;",
            ">;"
        }
    .end annotation
.end field

.field private updateAt:Ljava/lang/Long;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final getLaunchers()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/LauncherItemBean;",
            ">;"
        }
    .end annotation

    .line 10
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/LauncherRootBean;->launchers:Ljava/util/List;

    return-object v0
.end method

.method public final getUpdateAt()Ljava/lang/Long;
    .locals 1

    .line 11
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/LauncherRootBean;->updateAt:Ljava/lang/Long;

    return-object v0
.end method

.method public final setLaunchers(Ljava/util/List;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/LauncherItemBean;",
            ">;)V"
        }
    .end annotation

    .line 10
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/LauncherRootBean;->launchers:Ljava/util/List;

    return-void
.end method

.method public final setUpdateAt(Ljava/lang/Long;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/lang/Long;

    .line 11
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/api/feature/api/appconfig/LauncherRootBean;->updateAt:Ljava/lang/Long;

    return-void
.end method
