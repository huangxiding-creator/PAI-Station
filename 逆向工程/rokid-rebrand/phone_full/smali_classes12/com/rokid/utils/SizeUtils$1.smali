.class final Lcom/rokid/utils/SizeUtils$1;
.super Ljava/lang/Object;
.source "SizeUtils.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/utils/SizeUtils;->forceGetViewSize(Landroid/view/View;Lcom/rokid/utils/SizeUtils$onGetSizeListener;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic val$listener:Lcom/rokid/utils/SizeUtils$onGetSizeListener;

.field final synthetic val$view:Landroid/view/View;


# direct methods
.method constructor <init>(Lcom/rokid/utils/SizeUtils$onGetSizeListener;Landroid/view/View;)V
    .locals 0

    .line 109
    iput-object p1, p0, Lcom/rokid/utils/SizeUtils$1;->val$listener:Lcom/rokid/utils/SizeUtils$onGetSizeListener;

    iput-object p2, p0, Lcom/rokid/utils/SizeUtils$1;->val$view:Landroid/view/View;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .line 112
    iget-object v0, p0, Lcom/rokid/utils/SizeUtils$1;->val$listener:Lcom/rokid/utils/SizeUtils$onGetSizeListener;

    if-eqz v0, :cond_0

    .line 113
    iget-object v0, p0, Lcom/rokid/utils/SizeUtils$1;->val$listener:Lcom/rokid/utils/SizeUtils$onGetSizeListener;

    iget-object v1, p0, Lcom/rokid/utils/SizeUtils$1;->val$view:Landroid/view/View;

    invoke-interface {v0, v1}, Lcom/rokid/utils/SizeUtils$onGetSizeListener;->onGetSize(Landroid/view/View;)V

    .line 115
    :cond_0
    return-void
.end method
