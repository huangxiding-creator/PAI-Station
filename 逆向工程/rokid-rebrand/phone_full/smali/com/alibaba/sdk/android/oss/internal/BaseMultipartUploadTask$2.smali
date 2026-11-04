.class Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask$2;
.super Ljava/lang/Object;
.source "BaseMultipartUploadTask.java"

# interfaces
.implements Ljava/util/Comparator;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;->completeMultipartUploadResult()Lcom/alibaba/sdk/android/oss/model/CompleteMultipartUploadResult;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/util/Comparator<",
        "Lcom/alibaba/sdk/android/oss/model/PartETag;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic this$0:Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;


# direct methods
.method constructor <init>(Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;)V
    .locals 0
    .param p1, "this$0"    # Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;

    .line 315
    .local p0, "this":Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask$2;, "Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask$2;"
    iput-object p1, p0, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask$2;->this$0:Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public compare(Lcom/alibaba/sdk/android/oss/model/PartETag;Lcom/alibaba/sdk/android/oss/model/PartETag;)I
    .locals 2
    .param p1, "lhs"    # Lcom/alibaba/sdk/android/oss/model/PartETag;
    .param p2, "rhs"    # Lcom/alibaba/sdk/android/oss/model/PartETag;

    .line 318
    .local p0, "this":Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask$2;, "Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask$2;"
    invoke-virtual {p1}, Lcom/alibaba/sdk/android/oss/model/PartETag;->getPartNumber()I

    move-result v0

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/oss/model/PartETag;->getPartNumber()I

    move-result v1

    if-ge v0, v1, :cond_0

    .line 319
    const/4 v0, -0x1

    return v0

    .line 320
    :cond_0
    invoke-virtual {p1}, Lcom/alibaba/sdk/android/oss/model/PartETag;->getPartNumber()I

    move-result v0

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/oss/model/PartETag;->getPartNumber()I

    move-result v1

    if-le v0, v1, :cond_1

    .line 321
    const/4 v0, 0x1

    return v0

    .line 323
    :cond_1
    const/4 v0, 0x0

    return v0
.end method

.method public bridge synthetic compare(Ljava/lang/Object;Ljava/lang/Object;)I
    .locals 0

    .line 315
    .local p0, "this":Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask$2;, "Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask$2;"
    check-cast p1, Lcom/alibaba/sdk/android/oss/model/PartETag;

    check-cast p2, Lcom/alibaba/sdk/android/oss/model/PartETag;

    invoke-virtual {p0, p1, p2}, Lcom/alibaba/sdk/android/oss/internal/BaseMultipartUploadTask$2;->compare(Lcom/alibaba/sdk/android/oss/model/PartETag;Lcom/alibaba/sdk/android/oss/model/PartETag;)I

    move-result p1

    return p1
.end method
