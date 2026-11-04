.class public final synthetic Lio/minio/UploadSnowballObjectsArgs$Builder$$ExternalSyntheticLambda1;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Consumer;


# instance fields
.field public final synthetic f$0:Ljava/lang/Iterable;


# direct methods
.method public synthetic constructor <init>(Ljava/lang/Iterable;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/UploadSnowballObjectsArgs$Builder$$ExternalSyntheticLambda1;->f$0:Ljava/lang/Iterable;

    return-void
.end method


# virtual methods
.method public final accept(Ljava/lang/Object;)V
    .locals 1

    .line 0
    iget-object v0, p0, Lio/minio/UploadSnowballObjectsArgs$Builder$$ExternalSyntheticLambda1;->f$0:Ljava/lang/Iterable;

    check-cast p1, Lio/minio/UploadSnowballObjectsArgs;

    invoke-static {v0, p1}, Lio/minio/UploadSnowballObjectsArgs$Builder;->lambda$objects$0(Ljava/lang/Iterable;Lio/minio/UploadSnowballObjectsArgs;)V

    return-void
.end method
