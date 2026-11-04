.class Lcom/blankj/utilcode/util/FragmentUtils$Args;
.super Ljava/lang/Object;
.source "FragmentUtils.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/blankj/utilcode/util/FragmentUtils;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "Args"
.end annotation


# instance fields
.field final id:I

.field final isAddStack:Z

.field final isHide:Z

.field final tag:Ljava/lang/String;


# direct methods
.method constructor <init>(ILjava/lang/String;ZZ)V
    .locals 0
    .param p1, "id"    # I
    .param p2, "tag"    # Ljava/lang/String;
    .param p3, "isHide"    # Z
    .param p4, "isAddStack"    # Z

    .line 1841
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1842
    iput p1, p0, Lcom/blankj/utilcode/util/FragmentUtils$Args;->id:I

    .line 1843
    iput-object p2, p0, Lcom/blankj/utilcode/util/FragmentUtils$Args;->tag:Ljava/lang/String;

    .line 1844
    iput-boolean p3, p0, Lcom/blankj/utilcode/util/FragmentUtils$Args;->isHide:Z

    .line 1845
    iput-boolean p4, p0, Lcom/blankj/utilcode/util/FragmentUtils$Args;->isAddStack:Z

    .line 1846
    return-void
.end method

.method constructor <init>(IZZ)V
    .locals 1
    .param p1, "id"    # I
    .param p2, "isHide"    # Z
    .param p3, "isAddStack"    # Z

    .line 1837
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0, p2, p3}, Lcom/blankj/utilcode/util/FragmentUtils$Args;-><init>(ILjava/lang/String;ZZ)V

    .line 1838
    return-void
.end method
