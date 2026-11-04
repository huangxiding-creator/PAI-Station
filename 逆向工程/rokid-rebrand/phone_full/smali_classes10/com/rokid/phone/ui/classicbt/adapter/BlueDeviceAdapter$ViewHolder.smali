.class public final Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter$ViewHolder;
.super Landroidx/recyclerview/widget/RecyclerView$ViewHolder;
.source "BlueDeviceAdapter.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "ViewHolder"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0012\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0005\u0018\u00002\u00020\u0001B\u000f\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0004\u0008\u0004\u0010\u0005R\u0011\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0006\u0010\u0007\u00a8\u0006\u0008"
    }
    d2 = {
        "Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter$ViewHolder;",
        "Landroidx/recyclerview/widget/RecyclerView$ViewHolder;",
        "binding",
        "Lcom/rokid/phone/databinding/ItemLinkerDeviceBinding;",
        "<init>",
        "(Lcom/rokid/phone/databinding/ItemLinkerDeviceBinding;)V",
        "getBinding",
        "()Lcom/rokid/phone/databinding/ItemLinkerDeviceBinding;",
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


# instance fields
.field private final binding:Lcom/rokid/phone/databinding/ItemLinkerDeviceBinding;


# direct methods
.method public constructor <init>(Lcom/rokid/phone/databinding/ItemLinkerDeviceBinding;)V
    .locals 1
    .param p1, "binding"    # Lcom/rokid/phone/databinding/ItemLinkerDeviceBinding;

    const-string v0, "binding"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 36
    invoke-virtual {p1}, Lcom/rokid/phone/databinding/ItemLinkerDeviceBinding;->getRoot()Landroid/widget/LinearLayout;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    invoke-direct {p0, v0}, Landroidx/recyclerview/widget/RecyclerView$ViewHolder;-><init>(Landroid/view/View;)V

    iput-object p1, p0, Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter$ViewHolder;->binding:Lcom/rokid/phone/databinding/ItemLinkerDeviceBinding;

    return-void
.end method


# virtual methods
.method public final getBinding()Lcom/rokid/phone/databinding/ItemLinkerDeviceBinding;
    .locals 1

    .line 36
    iget-object v0, p0, Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter$ViewHolder;->binding:Lcom/rokid/phone/databinding/ItemLinkerDeviceBinding;

    return-object v0
.end method
