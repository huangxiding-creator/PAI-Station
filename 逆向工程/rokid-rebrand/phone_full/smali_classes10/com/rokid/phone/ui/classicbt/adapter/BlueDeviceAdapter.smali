.class public final Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter;
.super Landroidx/recyclerview/widget/RecyclerView$Adapter;
.source "BlueDeviceAdapter.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter$ViewHolder;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroidx/recyclerview/widget/RecyclerView$Adapter<",
        "Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter$ViewHolder;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00004\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0010\u0002\n\u0002\u0008\u0003\n\u0002\u0010 \n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0006\u0018\u00002\u0008\u0012\u0004\u0012\u00020\u00020\u0001:\u0001\u0016B\u001b\u0012\u0012\u0010\u0003\u001a\u000e\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u00060\u0004\u00a2\u0006\u0004\u0008\u0007\u0010\u0008J\u0014\u0010\u000b\u001a\u00020\u00062\u000c\u0010\u000c\u001a\u0008\u0012\u0004\u0012\u00020\u00050\nJ\u0018\u0010\r\u001a\u00020\u00022\u0006\u0010\u000e\u001a\u00020\u000f2\u0006\u0010\u0010\u001a\u00020\u0011H\u0016J\u0018\u0010\u0012\u001a\u00020\u00062\u0006\u0010\u0013\u001a\u00020\u00022\u0006\u0010\u0014\u001a\u00020\u0011H\u0016J\u0008\u0010\u0015\u001a\u00020\u0011H\u0016R\u001a\u0010\u0003\u001a\u000e\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u00060\u0004X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0014\u0010\t\u001a\u0008\u0012\u0004\u0012\u00020\u00050\nX\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0017"
    }
    d2 = {
        "Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter;",
        "Landroidx/recyclerview/widget/RecyclerView$Adapter;",
        "Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter$ViewHolder;",
        "onClick",
        "Lkotlin/Function1;",
        "Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;",
        "",
        "<init>",
        "(Lkotlin/jvm/functions/Function1;)V",
        "items",
        "",
        "submit",
        "devices",
        "onCreateViewHolder",
        "parent",
        "Landroid/view/ViewGroup;",
        "viewType",
        "",
        "onBindViewHolder",
        "holder",
        "position",
        "getItemCount",
        "ViewHolder",
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
.field private items:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;",
            ">;"
        }
    .end annotation
.end field

.field private final onClick:Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/functions/Function1<",
            "Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public static synthetic $r8$lambda$1swBWK5Wx4bNzIyBB5fUwknMnMk(Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter;Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;Landroid/view/View;)V
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter;->onBindViewHolder$lambda$0(Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter;Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;Landroid/view/View;)V

    return-void
.end method

.method public constructor <init>(Lkotlin/jvm/functions/Function1;)V
    .locals 1
    .param p1, "onClick"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    const-string v0, "onClick"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 11
    invoke-direct {p0}, Landroidx/recyclerview/widget/RecyclerView$Adapter;-><init>()V

    .line 10
    iput-object p1, p0, Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter;->onClick:Lkotlin/jvm/functions/Function1;

    .line 12
    invoke-static {}, Lkotlin/collections/CollectionsKt;->emptyList()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter;->items:Ljava/util/List;

    .line 9
    return-void
.end method

.method private static final onBindViewHolder$lambda$0(Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter;Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;Landroid/view/View;)V
    .locals 1
    .param p0, "this$0"    # Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter;
    .param p1, "$device"    # Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;
    .param p2, "it"    # Landroid/view/View;

    .line 31
    iget-object v0, p0, Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter;->onClick:Lkotlin/jvm/functions/Function1;

    invoke-interface {v0, p1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method


# virtual methods
.method public getItemCount()I
    .locals 1

    .line 34
    iget-object v0, p0, Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter;->items:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public bridge synthetic onBindViewHolder(Landroidx/recyclerview/widget/RecyclerView$ViewHolder;I)V
    .locals 1
    .param p1, "p0"    # Landroidx/recyclerview/widget/RecyclerView$ViewHolder;
    .param p2, "p1"    # I

    .line 9
    move-object v0, p1

    check-cast v0, Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter$ViewHolder;

    invoke-virtual {p0, v0, p2}, Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter;->onBindViewHolder(Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter$ViewHolder;I)V

    return-void
.end method

.method public onBindViewHolder(Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter$ViewHolder;I)V
    .locals 3
    .param p1, "holder"    # Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter$ViewHolder;
    .param p2, "position"    # I

    const-string v0, "holder"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 29
    iget-object v0, p0, Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter;->items:Ljava/util/List;

    invoke-interface {v0, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;

    .line 30
    .local v0, "device":Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;
    invoke-virtual {p1}, Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter$ViewHolder;->getBinding()Lcom/rokid/phone/databinding/ItemLinkerDeviceBinding;

    move-result-object v1

    iget-object v1, v1, Lcom/rokid/phone/databinding/ItemLinkerDeviceBinding;->tvDeviceName:Landroid/widget/TextView;

    invoke-virtual {v0}, Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;->getName()Ljava/lang/String;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 31
    invoke-virtual {p1}, Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter$ViewHolder;->getBinding()Lcom/rokid/phone/databinding/ItemLinkerDeviceBinding;

    move-result-object v1

    invoke-virtual {v1}, Lcom/rokid/phone/databinding/ItemLinkerDeviceBinding;->getRoot()Landroid/widget/LinearLayout;

    move-result-object v1

    new-instance v2, Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter$$ExternalSyntheticLambda0;

    invoke-direct {v2, p0, v0}, Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter$$ExternalSyntheticLambda0;-><init>(Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter;Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;)V

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 32
    return-void
.end method

.method public bridge synthetic onCreateViewHolder(Landroid/view/ViewGroup;I)Landroidx/recyclerview/widget/RecyclerView$ViewHolder;
    .locals 1
    .param p1, "p0"    # Landroid/view/ViewGroup;
    .param p2, "p1"    # I

    .line 9
    invoke-virtual {p0, p1, p2}, Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter;->onCreateViewHolder(Landroid/view/ViewGroup;I)Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter$ViewHolder;

    move-result-object v0

    check-cast v0, Landroidx/recyclerview/widget/RecyclerView$ViewHolder;

    return-object v0
.end method

.method public onCreateViewHolder(Landroid/view/ViewGroup;I)Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter$ViewHolder;
    .locals 2
    .param p1, "parent"    # Landroid/view/ViewGroup;
    .param p2, "viewType"    # I

    const-string v0, "parent"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 21
    invoke-virtual {p1}, Landroid/view/ViewGroup;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    .line 22
    nop

    .line 23
    nop

    .line 20
    const/4 v1, 0x0

    invoke-static {v0, p1, v1}, Lcom/rokid/phone/databinding/ItemLinkerDeviceBinding;->inflate(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Z)Lcom/rokid/phone/databinding/ItemLinkerDeviceBinding;

    move-result-object v0

    const-string v1, "inflate(...)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 25
    .local v0, "binding":Lcom/rokid/phone/databinding/ItemLinkerDeviceBinding;
    new-instance v1, Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter$ViewHolder;

    invoke-direct {v1, v0}, Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter$ViewHolder;-><init>(Lcom/rokid/phone/databinding/ItemLinkerDeviceBinding;)V

    return-object v1
.end method

.method public final submit(Ljava/util/List;)V
    .locals 1
    .param p1, "devices"    # Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;",
            ">;)V"
        }
    .end annotation

    const-string v0, "devices"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 15
    iput-object p1, p0, Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter;->items:Ljava/util/List;

    .line 16
    invoke-virtual {p0}, Lcom/rokid/phone/ui/classicbt/adapter/BlueDeviceAdapter;->notifyDataSetChanged()V

    .line 17
    return-void
.end method
