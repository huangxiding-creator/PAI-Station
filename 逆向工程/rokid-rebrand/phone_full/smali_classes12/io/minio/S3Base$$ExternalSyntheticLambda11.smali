.class public final synthetic Lio/minio/S3Base$$ExternalSyntheticLambda11;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Supplier;


# instance fields
.field public final synthetic f$0:Lio/minio/PartReader;


# direct methods
.method public synthetic constructor <init>(Lio/minio/PartReader;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/S3Base$$ExternalSyntheticLambda11;->f$0:Lio/minio/PartReader;

    return-void
.end method


# virtual methods
.method public final get()Ljava/lang/Object;
    .locals 1

    .line 0
    iget-object v0, p0, Lio/minio/S3Base$$ExternalSyntheticLambda11;->f$0:Lio/minio/PartReader;

    invoke-static {v0}, Lio/minio/S3Base;->lambda$putObjectAsync$24(Lio/minio/PartReader;)Lio/minio/PartSource;

    move-result-object v0

    return-object v0
.end method
